require 'sinatra/base'

# Require needed Ruby files.
Dir.glob('./helpers/*.rb').each { |file| require file }
require './controllers/application_controller.rb'
Dir.glob('./models/*.rb').each { |file| require file }
Dir.glob('./controllers/*.rb').each { |file| require file }

# Map route prefixes to specific controllers.
map('/') { run MainController }
map('/file/') { run FileController }
