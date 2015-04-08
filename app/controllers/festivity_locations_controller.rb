class FestivityLocationsController < ApplicationController
  no_login_required
  trusty_layout "base"

  def show
    @location = FestivityLocationPage.find_by_slug_for_site(params[:id]).first
    @location_events = FestivityEventList.find_by_location(@location.id)
    @title = "#{current_site.festivity_festival_name}: #{@location.title}"
  end

end