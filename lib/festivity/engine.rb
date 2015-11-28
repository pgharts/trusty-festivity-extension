module Festivity
  class Engine < Rails::Engine
    paths["app/helpers"] = []

    initializer "trusty_cms.assets.precompile" do |app|
      app.config.assets.precompile += %w(
        main.css
        first-night.css
        traf.css
        admin/festivity_admin.css
        admin/festivity_admin.js
        festivity.css
        festivity_app.js
        skins/pghkids/skin.css
        production/grunticon.loader.js
        production/*.css)
    end
  end
end
