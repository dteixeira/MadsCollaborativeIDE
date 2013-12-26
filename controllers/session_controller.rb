class SessionController < ApplicationController

  helpers SessionHelpers

  get '/login' do
    slim 'session/login'.to_sym
  end

  post '/login' do
    if @current_user.nil?
      @current_user = User.login params[:user]
      if @current_user.nil?
        flash[:error] = "Failed to login. Check your username and password."
        redirect "/session/login"
      else
        session[:user_id] = @current_user.id
        flash[:notice] = "Login successful."
        redirect "/"
      end
    else
      flash[:notice] = "You are already logged in."
      redirect "/"
    end
  end

  get '/logout' do
  end

  get '/register' do
    slim 'session/register'.to_sym
  end

  post '/register' do
  end

end
