class FestivityLocationAreasController < ApplicationController
  include Festivity::Mixins::NotFound
  no_login_required
  trusty_layout "normal"

  def show
    @area = FestivityLocationAreaPage.find_by_slug_for_site(params[:id]).first

    if @area
    @title = "#{current_site.festivity_festival_name}: #{@area.title}"
    else
      file_not_found_for_site
    end

  end

end