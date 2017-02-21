require 'deface'

module ForemanBuildHistory
  class Engine < ::Rails::Engine
    engine_name 'foreman_build_history'

    config.autoload_paths += Dir["#{config.root}/app/controllers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/models/concerns"]

    # Add any db migrations
    initializer 'foreman_build_history.load_app_instance_data' do |app|
      ForemanBuildHistory::Engine.paths['db/migrate'].existent.each do |path|
        app.config.paths['db/migrate'] << path
      end
    end

    initializer 'foreman_build_history.register_plugin', :before => :finisher_hook do |_app|
      Foreman::Plugin.register :foreman_build_history do
        requires_foreman '>= 1.12'

        # Add permissions
        security_block :foreman_build_history do
          permission :view_foreman_build_history, :'foreman_build_history/build_history' => [:index]
        end

        # Add a new role called 'ForemanBuildHistory' if it doesn't exist
        role 'ForemanBuildHistory', [:view_foreman_build_history]

        # add menu entry
        menu :top_menu, :template,
             url_hash: { controller: :'foreman_build_history/build_history', action: :index },
             caption: N_('Build history'),
             parent: :monitor_menu,
             after: :audits
      end
    end

    # Precompile any JS or CSS files under app/assets/
    # If requiring files from each other, list them explicitly here to avoid precompiling the same
    # content twice.
    assets_to_precompile =
      Dir.chdir(root) do
        Dir['app/assets/javascripts/**/*', 'app/assets/stylesheets/**/*'].map do |f|
          f.split(File::SEPARATOR, 4).last
        end
      end
    initializer 'foreman_build_history.assets.precompile' do |app|
      app.config.assets.precompile += assets_to_precompile
      app.config.assets.precompile += %w( timeline.css )
    end
    initializer 'foreman_build_history.configure_assets', group: :assets do
      SETTINGS[:foreman_build_history] = { assets: { precompile: assets_to_precompile } }
    end

    # Include concerns in this config.to_prepare block
    config.to_prepare do
      begin
        require File.expand_path('../facet', __FILE__)
        Host::Managed.send(:include, ForemanBuildHistory::HostExtensions)
        UnattendedController.send(:include, ForemanBuildHistory::UnattendedControllerExtensions)
      rescue => e
        Rails.logger.warn "ForemanBuildHistory: skipping engine hook (#{e})"
      end
    end

    initializer 'foreman_build_history.register_gettext', after: :load_config_initializers do |_app|
      locale_dir = File.join(File.expand_path('../../..', __FILE__), 'locale')
      locale_domain = 'foreman_build_history'
      Foreman::Gettext::Support.add_text_domain locale_domain, locale_dir
    end
  end
end
