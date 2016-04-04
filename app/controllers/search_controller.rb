class SearchController < ApplicationController
  include Concerns::FestivityCustomPage

  def show
    query = params[:q].to_s
    @keyword = query
    @page_number = page_number
    @result = GoogleCustomSearch::Search.new.with_page_index(@page_number).for url_encode("#{@keyword} site:#{current_site.base_domain}")
  end

  private
  def page_number
    page_number = params[:page_number] || 1
    page_number.to_i
  end
end