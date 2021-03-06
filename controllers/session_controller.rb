class SessionController < ApplicationController

  helpers SessionHelpers

  get '/login' do
    if @current_user.nil?
      slim 'session/login'.to_sym
    else
      flash[:notice] = "You are already logged in"
      redirect "/project/list"
    end
  end

  post '/login' do
    if @current_user.nil?
      @current_user = User.login params[:user]
      if @current_user.nil?
        flash[:error] = "Failed to login, check your username and password"
        redirect "/session/login"
      else
        session[:user_id] = @current_user.id
        flash[:notice] = "Login successful."
        redirect "/project/list"
      end
    else
      flash[:notice] = "You are already logged in"
      redirect "/project/list"
    end
  end

  get '/logout' do
    if @current_user.nil?
      flash[:error] = "You are not logged in"
      redirect "/"
    else
      session[:user_id] = nil
      flash[:notice] = "Logout successful"
      redirect "/"
    end
  end

  get '/register' do
    if @current_user.nil?
      slim 'session/register'.to_sym
    else
      flash[:notice] = "You are already logged in"
      redirect "/project/list"
    end
  end

  post '/register' do
    begin
      u = params[:user].inject({}) { |memo,(k,v)| memo[k.to_sym] = v; memo }
      user = User.new u
      if user.save
        session[:user_id] = user.id
        flash[:notice] = 'Register successful'
        redirect '/project/list'
      else
        str = ''
        user.errors.each do |k, v|
          next if k.nil?
          str += k + ';'
        end
        flash[:error] = str
        redirect '/session/register'
      end
    rescue Exception => e
      puts e
      flash[:error] = 'Failed to register account'
      redirect '/session/register'
    end
  end

end
