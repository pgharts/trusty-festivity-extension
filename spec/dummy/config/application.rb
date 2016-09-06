require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'acts_as_tree'
require "trusty_cms"
require 'ckeditor'
require 'radius'
require 'trusty_cms/extension_loader'
require 'trusty_cms/initializer'
require 'string_extensions/string_extensions'
require 'active_record_extensions/active_record_extensions'
require 'configuration_extensions/configuration_extensions'
require 'compass'
require 'rack/cache'
require "sass-rails"

if defined?(Bundler)
  require 'rake'
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module TrustyCms
  class Application < Rails::Application
    include TrustyCms::Initializer

    config.autoload_paths += %W(#{TRUSTY_CMS_ROOT}/lib)
    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += %W(#{config.root}/app/helpers)

    config.active_record.raise_in_transactional_callbacks = true

    Sass.load_paths << Compass::Frameworks['compass'].stylesheets_directory

    # Initialize extension paths
    config.initialize_extension_paths
    extension_loader = ExtensionLoader.instance {|l| l.initializer = self }
    extension_loader.paths(:load).reverse_each do |path, value|
      config.autoload_paths.unshift path
      $LOAD_PATH.unshift path
    end
    # config.add_plugin_paths(extension_loader.paths(:plugin))
    # TODO: Come back and look at this.
    radiant_locale_paths = Dir[File.join(TRUSTY_CMS_ROOT, 'config', 'locales', '*.{rb,yml}')]
    config.i18n.load_path = radiant_locale_paths + extension_loader.paths(:locale)

    config.encoding = 'utf-8'

    config.extensions = [:layouts, :snippets, :multi_site, :clipped, :rad_social]
    config.extensions_migration_order = [:clipped, :layouts, :snippets, :multi_site]

    # TODO: We're not sure this is actually working, but we can't really test this until the app initializes.
    config.middleware.use Rack::Cache,
                          :private_headers => ['Authorization'],
                          :entitystore => "radiant:tmp/cache/entity",
                          :metastore => "radiant:tmp/cache/meta",
                          :verbose => false,
                          :allow_reload => false,
                          :allow_revalidate => false
    # TODO: There's got to be a better place for this, but in order for assets to work fornow, we need ConditionalGet
    # TODO: Workaround from: https://github.com/rtomayko/rack-cache/issues/80
    config.middleware.insert_before(Rack::ConditionalGet, Rack::Cache)
    config.assets.enabled = true

    config.filter_parameters += [:password, :password_confirmation]

    # Make Active Record use UTC-base instead of local time
    config.time_zone = 'UTC'

    # Set the default field error proc
    config.action_view.field_error_proc = Proc.new do |html, instance|
      if html !~ /label/
        %{<span class="error-with-fieldxxxx">#{html} <span class="error">#{[instance.error_message].flatten.first}</span></span>}.try(:html_safe)
      else
        html
      end
    end

    config.after_initialize do
      extension_loader.load_extensions
      extension_loader.load_extension_initalizers

      #Dir["#{TRUSTY_CMS_ROOT}/config/initializers/**/*.rb"].sort.each do |initializer|
      #  load(initializer)
      #end

      extension_loader.activate_extensions  # also calls initialize_views
      # config.add_controller_paths(extension_loader.paths(:controller))
      #config.add_eager_load_paths(extension_loader.paths(:eager_load))

      # Add new inflection rules using the following format:
      ActiveSupport::Inflector.inflections do |inflect|
        inflect.uncountable 'config'
      end

    end
  end
end
