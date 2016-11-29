module Festivity
  class Engine < Rails::Engine
    paths["app/helpers"] = []

    initializer "trusty_cms.assets.precompile" do |app|
      app.config.assets.precompile += %w(
        main.css
        skins/buzzword/*.css
        skins/crawl/*.css
        skins/first-night/*.css
        skins/pghkids/*.css
        skins/traf/*.css
        skins/buzzword/*.css
        admin/*.css
        admin/*.js
        festivity_app.js
        production/grunticon.loader.js
        production/*.css)
    end
  end

end
