module Festivity
  class Engine < Rails::Engine
    paths["app/helpers"] = []

    initializer "trusty_cms.assets.precompile" do |app|
      app.config.assets.precompile += %w(admin/festivity_admin.css admin/festivity_admin.js festivity.css festivity_app.js skins/pghkids/skin.css)
    end
  end
end
