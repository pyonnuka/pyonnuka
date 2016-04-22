require 'pyonnuka'
require 'pathname'
require 'active_support'
require 'active_support/dependencies/autoload'
require 'active_support/core_ext/kernel/reporting'
require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/array/extract_options'

module Pyonnuka
  extend ActiveSupport::Autoload

  autoload :WelcomeController

  class << self
    @application = @app_class = nil

    def application
      app = <%= @app_name %>::Application.new
    end
  end
end

module <%= @app_name %>
  class Application < Pyonnuka::Application
  end
end
