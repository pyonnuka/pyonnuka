module Pyonnuka
  class Application
    attr_accessor :env, :request, :response, :params

    def call(env) # :nodoc:
      @request = Rack::Request.new(env)
      @response = Rack::Response.new
      @params = request.params
      @url = request.fullpath()

      @filename = filename
      file = ::Slim::Template.new(filename, pretty: true).render()

      [ @response.status.to_i, @response.header, file.split('\n')]
    end

    def filename
      # TODO: can add rooting
      "app/views#{@url}.html.slim"
    end

    class Server
      class << self
        def start(command)
          production_option = 'all_of_the_world'

          if command[1] == production_option
            on_server(' -E production -p 8080 -o 0.0.0.0')
          elsif command[1].nil?
            on_server
          else
            puts "warning: on server with unknown mode #{command[1]}"
            on_server
          end
        end

        def on_server(option=nil)
          system("rackup #{option}")
        end
      end
    end
  end

  module Generators
    require 'fileutils'
    require 'erb'

    class AppGenerator
      def initialize app_name
        @app_name = app_name
      end

      def start
        puts "Project #{@app_name} is now creating..."
        ::FileUtils.mkdir(@app_name)

        %w(gemfile configru app config).each do |file|
          self.send("create_#{file}")
        end
      end

      def create_gemfile
        ::FileUtils.cp(File.join(File.dirname(__FILE__), './templates/Gemfile'), "#{@app_name}/Gemfile")
      end

      def create_configru
        ::FileUtils.cp(File.join(File.dirname(__FILE__), './templates/config.ru'), "#{@app_name}/config.ru")
      end

      def create_app
        ::FileUtils.cp_r(File.join(File.dirname(__FILE__), './templates/app/'), "#{@app_name}/app/")
      end

      def create_config
        ::FileUtils.mkdir("#{@app_name}/config")
        erb = ::ERB.new(File.read(File.join(File.dirname(__FILE__), './templates/config/application.rb')))
        File.open("#{@app_name}/config/application.rb", 'w') do |f|
          f.write(erb.result(binding))
        end
      end
    end
  end
end
