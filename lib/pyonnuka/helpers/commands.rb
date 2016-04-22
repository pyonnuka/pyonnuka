module Pyonnuka
  module Helpers
    class Command
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
end
