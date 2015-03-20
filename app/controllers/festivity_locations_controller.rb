class FestivityLocationsController < ApplicationController
  no_login_required
  trusty_layout "normal"

  def show
    @location = FestivityLocationPage.find_by_slug_for_site(params[:id]).first
  end

end