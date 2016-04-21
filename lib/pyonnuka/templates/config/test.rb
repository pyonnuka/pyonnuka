require 'erb'

file = ERB.new(File.read('./application.rb')).result(binding)
puts file
