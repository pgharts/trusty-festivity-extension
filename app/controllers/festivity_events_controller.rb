class FestivityEventsController < ApplicationController
  include Festivity::Mixins::NotFound
  no_login_required
  trusty_layout 'base'

  caches_action :index, cache_path: proc { |c| c.params.except(:_).merge(format: request.xhr?, base_domain: "#{request.subdomain}.#{request.domain}")}
  caches_action :show

  def index

    order_by = params[:sort] ? params[:sort] : "start_date"
    @title = "#{current_site.festivity_festival_name}: Events"
    @filter_type = current_site.festivity_filter_type
    @events =  Rails.cache.fetch("#{cache_key}", expires_in: 2.hours) do
      FestivityEventList.search(
          {dates: search_dates.join(","),
           categories: params[:categories],
          filter_type: current_site.festivity_filter_type},
          order_by).events
    end


    @selected_dates = params[:dates] ? FestivityDatetimeFilterPresenter.parse(params[:dates].split(","), current_site.festivity_filter_type) : []
    @selected_categories = params[:categories] ? params[:categories].split(",") : []
    @selected_sort = order_by
    # If the request is AJAX, only return the event list itself, not the full page
    if request.xhr?
      render partial: "event_list"
    else
      render 'index'
    end

  end

  def show
    @event = FestivityEventPage.find_by_slug_and_status_id(params[:id], Status[:published].id)
    if @event
      @page = @event
      @related_events = FestivityEventList.find_related_events(
          {dates: search_dates.join(","), event_id: @event.id,
           categories: @event.festivity_categories.map{|cat| cat.id}}).events
      @title = "#{current_site.festivity_festival_name}: #{@event.title}"
    else
      file_not_found_for_site
    end

  end

  private

  def cache_key
    "#{params[:categories.to_s]}-#{params[:dates].to_s}-#{params[:sort].to_s}-#{request.xhr?}-#{request.subdomain}.#{request.domain}"
  end

  def search_dates
    if params[:dates]
      params[:dates].split(",")
    else
      FestivityEventList.collect_festival_dates(current_site)
    end

  end


end