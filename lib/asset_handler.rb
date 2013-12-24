class AssetHandler < Sinatra::Base

  # Configurations.
  configure do
    set :root, File.expand_path('../../', __FILE__)
    set :views, settings.root + '/assets'
    set :jsdir, 'javascripts'
    set :csdir, 'coffeescripts'
  end

  # Serve Coffescript.
  get '/coffeescripts/*.js' do
    last_modified File.mtime(settings.root + '/assets/' + settings.csdir)
    cache_control :public, :must_revalidate
    coffee (settings.csdir + '/' + params[:splat].first).to_sym
  end

  # Serve JavaScript.
  get '/javascripts/*.js' do
    send_file(settings.views + '/' + settings.jsdir + '/' + params[:splat].first + '.js')
  end

  # Serve CSS.
  get '/stylesheets/*.css' do
    content_type 'text/css', :charset => 'utf-8'
    scss("stylesheets/#{params[:splat].first}".to_sym)
  end

end
