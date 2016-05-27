module Festivity
  class Engine < Rails::Engine
    paths["app/helpers"] = []

    initializer "trusty_cms.assets.precompile" do |app|
      app.config.assets.precompile += %w(
        main.css
        skins/crawl/skin.css
        skins/first-night/skin.css
        skins/pghkids/skin.css
        skins/traf/skin.css
        admin/festivity_admin.css
        admin/festivity_admin.js
        festivity_app.js
        grunticon/production/grunticon.loader.js
        grunticon/production/*.css)
    end
  end

end
