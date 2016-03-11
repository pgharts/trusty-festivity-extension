module Festivity
  class Engine < Rails::Engine
    paths["app/helpers"] = []

    initializer "trusty_cms.assets.precompile" do |app|
      app.config.assets.precompile += %w(
        main.css
        first-night.css
        traf.css
        pghkids.scss
        admin/festivity_admin.css
        admin/festivity_admin.js
        festivity.css
        festivity_app.js
        grunticon/production/grunticon.loader.js
        grunticon/production/*.css)
    end
  end
end
