# Uncomment this if you reference any of your controllers in activate
# require_dependency "application_controller"
require "trusty-festivity-extension"
class FestivityExtension < TrustyCms::Extension
  version     TrustyFestivityExtension::VERSION
  description TrustyFestivityExtension::DESCRIPTION
  url         TrustyFestivityExtension::URL

  def activate
    require 'fog'
    require 'actionpack/action_caching'
    admin.page.edit.add(:form, "festivity_includes", :before => 'edit_page_parts')
    admin.page.edit.add(:form, "festivity_featured_image_fields", :after => 'edit_page_parts')
    admin.page.edit.add(:form, "festivity_base_fields", :after => 'edit_page_parts')
    admin.page.edit.add(:form, "festivity_location_fields", :after => 'edit_page_parts')
    admin.site.edit.add(:form, "festivity_site_fields", :after => 'edit_homepage')

    Admin::AssetsController.send :include, Festivity::Extensions::PaperclippedExtensions
    Site.send :include, Festivity::Extensions::SiteExtensions
    Page.send :include, Festivity::Extensions::PageExtensions
    Admin::PagesHelper.send :include, Festivity::Extensions::PagesHelperExtensions
    Page.send :include, Tags::NavigationTags
    Page.send :include, Tags::HeaderTags
  end

end
