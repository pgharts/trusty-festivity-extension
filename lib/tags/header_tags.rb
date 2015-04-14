module Tags::HeaderTags
  include TrustyCms::Taggable

  desc "Meta Tags"
  tag "festivity_meta" do |tag|
    page = Page.find_by_slug_for_site(tag.locals.page.slug).first
    description = get_content(page, :description)
    keywords = get_content(page, :keywords)
    domain = "#{request.protocol}#{request.host}"
    request.env["action_controller.instance"].render_to_string :partial => "header/meta_tags",
                                                               :locals => {:domain => domain,
                                                                           :description => description,
                                                                           :keywords => keywords,
                                                                           :page => page,
                                                                           :url => request.url}

  end

  desc "Omniture Variables"
  tag "omniture_vars" do |tag|
    domain = "#{request.protocol}#{request.host}"
    if tag.locals.page.breadcrumb
      %{<script language="JavaScript" type="text/javascript"><!--
  s.pageName="#{domain}:#{tag.locals.page.breadcrumb}";
  s.channel="#{domain}:#{tag.locals.page.breadcrumb}";
  s.server="#{domain}";
  var s_code=s.t();
//--></script>}
    end
  end

  def get_content(page, type)
    if page.field(type) && !page.field(type).content.blank?
      CGI.escapeHTML(page.field(type).content)
    end

  end

end

