class FestivityLocationsController < ApplicationController
  include Festivity::Mixins::NotFound
  no_login_required
  trusty_layout "base"
  caches_action :show

  def show
    @location = FestivityLocationPage.find_by_slug_for_site(params[:id]).first
    if @location
      @location_events = FestivityEventList.find_by_location(@location.id)
      @title = "#{current_site.festivity_festival_name}: #{@location.title}"
    else
      file_not_found_for_site
    end

  end

end