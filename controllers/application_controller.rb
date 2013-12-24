$:.unshift(File.expand_path('../../lib', __FILE__))

# Require Sinatra modules.
require 'sinatra'
require 'sinatra/advanced_routes'
require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'
require 'sinatra/contrib/all'

# Require assets.
require 'compass'
require 'slim'
require 'sass'
require 'coffee-script'
require 'v8'
require 'cgi'
require 'json'
require 'data_mapper'

# Require own libraries.
require 'asset_handler'

class ApplicationController < Sinatra::Base

  ##############################################################################
  # Any global variables go in here.
  ##############################################################################

  # AM_I_A_GLOBAL = 'yep'

  ##############################################################################
  # DataMapper configurations. Don't forget to install the correct adapter for
  # the type of database you are using.
  ##############################################################################

  # Enables database logging.
  # DataMapper::Logger.new($stdout, :debug)

  # To use a SQLite3 in-memory database.
  # DataMapper.setup(:default, 'sqlite::memory:')

  # To use a SQLite3 persistent database.
  # DataMapper.setup(:default, 'sqlite:///path/to/project.db')

  # To use a MySQL database.
  # DataMapper.setup(:default, 'mysql://user:password@hostname/database')

  # To use a Postgres database.
  # DataMapper.setup(:default, 'postgres://user:password@hostname/database')

  # Finalizes all models.
  # DataMapper.finalize

  # Upgrades the database schema. This won't modify any existing columns, only
  # add new columns or tables. Database data is kept.
  # DataMapper.auto_upgrade!

  # Migrates entire schema. This will drop all tables before recreating the
  # the schema, so all data is deleted. Use with caution.
  # DataMapper.auto_migrate!

  ##############################################################################
  # Register Sinatra modules.
  ##############################################################################

  register Sinatra::AdvancedRoutes
  register Sinatra::Flash
  register Sinatra::Partial
  register Sinatra::Contrib

  ##############################################################################
  # Include any application-wide helpers.
  ##############################################################################

  helpers ApplicationHelpers

  ##############################################################################
  # General configurations.
  ##############################################################################

  configure do

    # Sets needed variables.
    set :root, File.expand_path('../../', __FILE__)
    set :views, File.expand_path('../../views', __FILE__)
    set :partial_template_engine, :slim
    set :static, true
    set :public_folder, File.expand_path('../../public', __FILE__)
    set :scss, { :style => :compact, :debug_info => true }

    # Compass configurations.
    Compass.add_project_configuration(File.join(settings.root, 'config', 'compass.rb'))

    # Enable needed behaviour.
    enable :sessions
    enable :method_override
    enable :partial_underscores

  end

  ##############################################################################
  # Includes needed library files.
  ##############################################################################

  use AssetHandler

  ##############################################################################
  # Defines generic behaviour on 404.
  ##############################################################################

  not_found{ slim :not_found }

end
