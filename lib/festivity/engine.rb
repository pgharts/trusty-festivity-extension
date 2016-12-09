module Festivity
  class Engine < Rails::Engine
    paths["app/helpers"] = []

    initializer "trusty_cms.assets.precompile" do |app|
      app.config.assets.precompile += %w(
        admin/festivity-admin.css
        admin/*.js
        main.css
        skins/buzzword/skin.css
        skins/crawl/skin.css
        skins/first-night/skin.css
        skins/pghkids/skin.css
        skins/traf/skin.css
        skins/buzzword/skin.css
        festivity_app.js
        production/grunticon.loader.js
        production/*.css)
    end
  end

end
