class FestivityEventsController < ApplicationController
  no_login_required
  trusty_layout 'base'

  def index
    order_by = params[:sort] ? params[:sort] : "start_date"

    @events = FestivityEventList.search(
        {dates: search_dates.join(","),
         categories: params[:categories]},
        order_by).events

    @selected_dates = params[:dates] ? params[:dates].split(",") : []
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
  end

  private

  def search_dates
    if params[:dates]
      params[:dates].split(",")
    else
      collect_festival_dates
    end

  end

  def collect_festival_dates
    festival_dates = current_site.festival_dates
    if current_site.date_during_festival?(Date.today)
      festival_dates = festival_dates.select{ |date| date == Date.today }
    end

    festival_dates.map{ |date| date.to_s }

  end


end