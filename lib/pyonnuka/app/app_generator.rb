module Pyonnuka
  class AppBuilder
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
        ::FileUtils.cp(File.join(File.dirname(__FILE__), '../templates/Gemfile'), "#{@app_name}/Gemfile")
      end

      def create_configru
        ::FileUtils.cp(File.join(File.dirname(__FILE__), '../templates/config.ru'), "#{@app_name}/config.ru")
      end

      def create_app
        ::FileUtils.cp_r(File.join(File.dirname(__FILE__), '../templates/app/'), "#{@app_name}/app/")
      end

      def create_config
        ::FileUtils.mkdir("#{@app_name}/config")
        erb = ::ERB.new(File.read(File.join(File.dirname(__FILE__), '../templates/config/application.rb')))
        File.open("#{@app_name}/config/application.rb", 'w') do |f|
          f.write(erb.result(binding))
        end
      end
    end
  end
end
