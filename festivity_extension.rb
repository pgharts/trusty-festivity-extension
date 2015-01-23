# Uncomment this if you reference any of your controllers in activate
# require_dependency "application_controller"
require "trusty-festivity-extension"

class FestivityExtension < TrustyCms::Extension
  version     TrustyFestivityExtension::VERSION
  description TrustyFestivityExtension::DESCRIPTION
  url         TrustyFestivityExtension::URL

  def activate
  end

end
