module Tags::HeaderTags
  include TrustyCms::Taggable

  desc "Meta Tags"
  tag "festivity_meta" do |tag|
    description = tag.locals.page.description.blank? ? "" : CGI.escapeHTML(tag.locals.page.description)
    keywords = CGI.escapeHTML(tag.locals.page.field(:keywords).try(:content)) if tag.locals.page.field(:keywords)
    page = tag.locals.page
    domain = "#{request.protocol}#{request.host}"
    request.env["action_controller.instance"].render_to_string :partial => "header/meta_tags",
                                                               :locals => {:domain => domain,
                                                                           :description => description,
                                                                           :keywords => keywords,
                                                                           :page => page,
                                                                           :url => request.url}
  end
end

