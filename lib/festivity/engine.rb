module Festivity
  class Engine < Rails::Engine
    paths["app/helpers"] = []

    initializer "trusty_cms.assets.precompile" do |app|
      app.config.assets.precompile += %w(admin/festivity_admin.css admin/festivity_admin.js festivity_admin.css)
    end
  end
end
