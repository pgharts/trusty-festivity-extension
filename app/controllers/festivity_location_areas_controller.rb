class FestivityLocationAreasController < ApplicationController
  no_login_required
  trusty_layout "normal"

  def show
    @area = FestivityLocationAreaPage.find_by_slug_for_site(params[:id]).first
    @title = "#{current_site.festivity_festival_name}: #{@area.title}"
  end

end