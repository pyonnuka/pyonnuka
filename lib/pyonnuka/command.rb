module Pyonnuka
  class Command
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
          when 'ikeikegogo'
            Pyonnuka::Application::Server.start(ARGV)
          when '-h'
            out_help
          when '-v'
            puts "Pyonnuka #{Pyonnuka::VERSION}"
        end
      end
    end

    private

    class << self
      def out_help
        puts <<"EOS"
Example:
    pyonnuka new ~/Code/Ruby/taskapp

      This generates a skeletal Pyonnuka installation in ~/Code/Ruby/taskapp.
      See the README in the newly created application to get going.
Pyonnuka options:
    -h  # Show this help message
    -v  # Show this pyonnuka version
EOS
      end

      def validate_app_path(app_path)
        return true if app_path.present? && ['Pyonnuka', 'pyonnuka'].exclude?(app_path)

        puts app_path.nil? ?  'required application path' : 'Invalid application name pyonnuka. Please choose another name'
        false
      end
    end
  end
end