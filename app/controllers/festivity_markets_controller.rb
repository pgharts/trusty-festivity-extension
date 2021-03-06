class FestivityMarketsController < ApplicationController
  include Concerns::FestivityCustomPage
  include Concerns::FestivitySearchCaching
  before_action { expires_in 1.hour, :public => true }

  def index

    order_by = params[:sort] ? params[:sort] : "start_date"
    @title = "#{current_site.festivity_festival_name}: Artist's Market"
    @filter_type = current_site.festivity_filter_type
    @markets =  Rails.cache.fetch("#{cache_key}", expires_in: 2.hours) do
      FestivityMarketList.search(
        {dates: search_dates.join(","),
         categories: params[:categories],
         filter_type: current_site.festivity_filter_type}, order_by
      ).markets
    end


    @selected_dates = params[:dates] ? FestivityDatetimeFilterPresenter.parse(params[:dates].split(","), current_site.festivity_filter_type) : []
    @selected_categories = params[:categories] ? params[:categories].split(",") : []
    @selected_sort = order_by
    # If the request is AJAX, only return the market list itself, not the full page
    if request.xhr?
      render partial: "market_list"
    else
      render 'index'
    end

  end

  def show
    @market = FestivityMarketPage.find_by_slug_and_status_id(params[:id], Status[:published].id)
    if @market
      @page = @market
      @title = "#{current_site.festivity_festival_name}: #{@market.title}"
    else
      file_not_found_for_site
    end

  end

  private

  def cache_key
    "markets-#{params[:categories.to_s]}-#{params[:dates].to_s}-#{params[:sort].to_s}-#{request.xhr?}-#{request.subdomain}.#{request.domain}"
  end

  def search_dates
    if params[:dates]
      params[:dates].split(",")
    else
      collect_festival_dates
    end

  end

  def collect_festival_dates
    festival_dates = current_site.festival_datetimes
    if current_site.date_during_festival?(Time.now)
      festival_dates = festival_dates.select{ |date| date.datetime == Time.now }
    end

    festival_dates.map{ |date| date.to_s }

  end

end
