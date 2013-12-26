module ApplicationHelpers

  def css(*stylesheets)
      stylesheets.map do |stylesheet|
        "<link href=\"/stylesheets/#{stylesheet}.css\" media=\"screen, projection\" rel=\"stylesheet\"></link>"
      end.join
  end

  def js(*javascripts)
    javascripts.map do |javascript|
      "<script type=\"text/javascript\" src=\"/javascripts/#{javascript}.js\"></script>"
    end.join
  end

  def cs(*coffeescripts)
    coffeescripts.map do |coffeescript|
      "<script type=\"text/javascript\" src=\"/coffeescripts/#{coffeescript}.js\"></script>"
    end.join
  end

  def current?(path='/')
    request.path_info==path ? "current":  nil
  end

  def check_login
    if @current_user.nil?
      flash[:error] = "You don't have permissions to access this page"
      redirect '/'
    end
  end

end
