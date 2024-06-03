require_relative 'middlewares/track_current_request'

module Rails
  module Monitor
    class Engine < ::Rails::Engine
      isolate_namespace Rails::Monitor

      initializer 'rails_monitor.init' do |app|
        RequestsBuffer.init
      end

      initializer 'rails_monitor.middlewares' do |app|
        app.middleware.insert_after ActionDispatch::Executor, TrackCurrentRequest
      end

      initializer 'rails_monitor.routing' do |app|
        app.routes.append do
          mount Engine => Monitor.config.prefix
        end
      end

      initializer 'rails_monitor.precompile' do |app|
        app.config.assets.precompile += %w[
          rails/monitor/application.css
          rails/monitor/application.js
        ]
      end

      initializer 'rails_monitor.subscribe' do |app|
        require_relative 'subscribers/action_controller'
        Subscribers::ActionController.subscribe
        require_relative 'subscribers/active_record'
        Subscribers::ActiveRecord.subscribe
      end
    end
  end
end
