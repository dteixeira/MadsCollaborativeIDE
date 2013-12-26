class SessionController < ApplicationController

  helpers SessionHelpers

  get '/login' do
    slim 'session/login'.to_sym
  end

  post '/login' do
  end

  get '/logout' do
  end

  get '/register' do
    slim 'session/register'.to_sym
  end

  post '/register' do
  end

end
