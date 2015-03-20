class FestivityLocationAreasController < ApplicationController
  no_login_required
  trusty_layout "normal"

  def show
    @area = FestivityLocationAreaPage.find_by_slug_for_site(params[:id]).first
  end

end