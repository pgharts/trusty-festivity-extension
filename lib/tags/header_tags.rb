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

end

