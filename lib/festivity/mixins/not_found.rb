module Festivity::Mixins::NotFound

  def file_not_found_for_site
    not_found_page = FileNotFoundPage.where(site_id: current_site.id).first
    not_found_page.process(request, response)
    @performed_render ||= true
    render 'site/show_page', layout: false
  end

end