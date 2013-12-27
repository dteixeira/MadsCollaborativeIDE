require 'sinatra/base'

# Require needed Ruby files.
require './controllers/application_controller.rb'

# Map route prefixes to specific controllers.
map('/') { run MainController }
map('/session/') { run SessionController }
map('/project/') { run ProjectController }

