class FestivityLocationAreasController < ApplicationController
  include Concerns::FestivityCustomPage
  before_action { expires_in 1.hour, :public => true }

  def show
    @area = FestivityLocationAreaPage.find_by_slug_for_site(params[:id]).first

    if @area
      @title = "#{current_site.festivity_festival_name}: #{@area.title}"
    else
      file_not_found_for_site
    end

  end

end