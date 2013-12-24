class MainController < ApplicationController

  helpers MainHelpers

  get '/' do
    # Render default view.
    slim 'main/index'.to_sym
  end

end
