require 'sinatra/base'

# Require needed Ruby files.
Dir.glob('./{models,helpers}/*.rb').each { |file| require file }
require './controllers/application_controller.rb'
Dir.glob('./controllers/*.rb').each { |file| require file }

# Map route prefixes to specific controllers.
map('/') { run MainController }
