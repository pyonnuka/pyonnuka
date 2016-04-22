module Pyonnuka
  class Application
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
end