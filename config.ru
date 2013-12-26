require 'sinatra/base'

# Require needed Ruby files.
require './controllers/application_controller.rb'

# Map route prefixes to specific controllers.
map('/') { run MainController }
map('/file/') { run FileController }
map('/session/') { run SessionController }
map('/git/') { run GitController }

