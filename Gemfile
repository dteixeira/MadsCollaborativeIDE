################################################################################
# This Gemfile installs gems that are pretty standard among Sinatra projects.
# You're more than welcome to change it or add any other gems that you might
# need. Just don't forget to change the app configurations.
#
# Diogo Teixeira, 2013
################################################################################

source 'https://rubygems.org'

# Ruby required version.
ruby '2.0.0'

################################################################################
# Environment gems and configurations
################################################################################

# This is a gemset definition for RVM. If you don't want to use this specific
# gemset just delete the line. If RVM is not installed this line can be left,
# but will do nothing.
#ruby-gemset=sinatra_bootstrap

# Pry is a Ruby shell, much more powerful than the standard shell (irb). It's
# not essencial to the project and you can opt no to install it, but it will
# make your life much easier. As this gem is not application breaking, no
# version is enforced.
gem "pry"

################################################################################
# Server gems
################################################################################

# Shotgun is a reloading gem for Sinatra apps. It's easy to use, and might
# come in handy for small applications. It realoads the entire app not only
# on source modifications but also after every request, so it's completely
# overkill for large projects. Use at your own risk (and mental sanity).
# Internally, shotgun uses unix' fork, so it won't work on Windows. By default
# this bootstrap will use Sinatra Contrib's reloader.
# gem "shotgun", "~> 0.9"

# Thin is a ruby web server alternative to WebBrick. Contrary to WebBrick, Thin
# is solid and fast enough to be used in production, being tipically faster
# than Mongrel. To use Thin as the server just call "thin start -R config.ru".
gem "thin", "~> 1.6.1"

################################################################################
# Sinatra specific gems
################################################################################

# Sinatra web framework.
gem "sinatra", "~> 1.4.4"

# Sinatra's contributor code. This is needed for some advanced features like
# app reloading, that are no longer integrated in the main gem.
gem "sinatra-contrib", "~> 1.4.1"

# This gem is used to simplify session flash management. It also includes a
# style helper to make flash viewing easier.
gem "sinatra-flash", "~> 0.3.0"

# Defines a simple helper for partial file importing. Not really essential, but
# makes your life easier.
gem "sinatra-partial", "~> 0.4.0"

# Needed for Compass routes.
gem "sinatra-advanced-routes", "~> 0.5.3"

################################################################################
# Resource specific gems
################################################################################

# The ptools gems is used to determine if a file is binary or text.
gem "ptools", "~> 1.2.2"

# TheRubyRacer is an embeds the V8 engine in Ruby. It's used to speed up
# coffeescript compilation. It might also be used to embed JS code in Ruby and
# vice versa, but unless you're working in a very specialized team where every
# member only knows one of the technologies, avoid using it.
gem "therubyracer", "~> 0.12.0"

# Slim is a very simple identation based template language, used to embed Ruby
# code in HTML. Slim files should have the ".slim" extension.
gem "slim", "~> 2.0.2"

# SASS extends the CSS3 markup, adding variable, control structure, mixins, etc.
# It is fully compatible with CSS3, allowing mixing of both styles.
gem "sass", "~> 3.2.12"

# Compass streamlines the creation of SASS CSS. It automatically adds all
# browser specific classes, removing that burden from the programmer.
gem "compass", "~> 0.12.2"

# Wrapper for the JS CoffeeScript compiler.
gem "coffee-script", "~> 2.2.0"

# Adds JSON handling capabilities.
gem "json", "~> 1.8.1"

# Adds DataMapper ORM.
gem "data_mapper", "~> 1.2.0"
