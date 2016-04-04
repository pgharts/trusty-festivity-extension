class FestivityLocationAreasController < ApplicationController
  include Concerns::FestivityCustomPage

  def show
    @area = FestivityLocationAreaPage.find_by_slug_for_site(params[:id]).first

    if @area
      @title = "#{current_site.festivity_festival_name}: #{@area.title}"
    else
      file_not_found_for_site
    end

  end

end