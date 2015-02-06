# Uncomment this if you reference any of your controllers in activate
# require_dependency "application_controller"
require "trusty-festivity-extension"

class FestivityExtension < TrustyCms::Extension
  version     TrustyFestivityExtension::VERSION
  description TrustyFestivityExtension::DESCRIPTION
  url         TrustyFestivityExtension::URL

  def activate

    admin.page.edit.add(:form, "festivity_base_fields", :after => 'edit_page_parts')
    admin.site.edit.add(:form, "festivity_site_fields", :after => 'edit_homepage')

    Site.send :include, Festivity::Extensions::SiteExtensions
  end

end
