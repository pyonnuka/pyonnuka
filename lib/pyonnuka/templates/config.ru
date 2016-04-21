require 'rubygems'
require 'rack'
Dir[File.expand_path('../config', __FILE__) << '/*.rb'].each do |file|
  require file
end
Dir[File.expand_path('../app', __FILE__) << '/*.rb'].each do |file|
  require file
end

# if you want to rub production mode,
# you run "rackup config.ru -p 8080 -o 0.0.0.0"
run Pyonnuka.application
