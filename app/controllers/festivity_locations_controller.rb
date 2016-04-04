class FestivityLocationsController < ApplicationController
  include Concerns::FestivityCustomPage

  def show
    @location = FestivityLocationPage.find_by_slug_for_site(params[:id]).first
    if @location
      @location_events = @title = Rails.cache.fetch("location-#{@location.slug}", expires_in: 2.hours) do
        FestivityEventList.find_by_location(@location.id, current_site)
      end
      @title = "#{current_site.festivity_festival_name}: #{@location.title}"
    else
      file_not_found_for_site
    end

  end

end