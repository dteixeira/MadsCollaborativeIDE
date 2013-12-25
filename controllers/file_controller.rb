class FileController < ApplicationController

  helpers FileHelpers

  post '/set_root' do
    return 'Internal error' if params[:root].nil? || params[:root].empty? || !File.directory?(params[:root])
    settings.browser_root = params[:root][-1, 1] == '/' ? params[:root].slice(0...-1) : params[:root]
  end

  post '/list_directory' do
    @files = list_directory settings.browser_root, params[:dir]
    slim 'file/list'.to_sym
  end

end
