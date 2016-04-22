require 'pyonnuka/helpers/commands'

module Pyonnuka
  class Command < Pyonnuka::Helpers::Command
    class << self
      def discriminate_command(command)
        if command[0].nil?
          out_help
          return
        end

        case command[0]
          when 'new'
            app_path = command[1]
            return unless validate_app_path(app_path)
            generator = Pyonnuka::Generators::AppGenerator.new(app_path)
            generator.start
          when '-h'
            out_help
          when '-v'
            puts "Pyonnuka #{Pyonnuka::VERSION}"
        end
      end
    end
  end
end
