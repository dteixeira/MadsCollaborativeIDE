class FileController < ApplicationController

  helpers FileHelpers

  # List a directory to the first depth level.
  post '/list_directory' do
    @files = list_directory settings.browser_root, params[:dir]
    slim 'file/list'.to_sym, :layout => :bare_layout
  end

  # Returns the unique hash of a file.
  post '/file_hash' do
    file = params[:file]
    return { success: false }.to_json if file.nil? || file.empty? || !valid_file(settings.browser_root, file)
    return { success: true, hash: generate_hash(settings.project_id, file), project: settings.project_id }.to_json
  end

  # Returns a files contents.
  post '/load_file' do
    file = params[:file]
    return { success: false }.to_json if file.nil? || file.empty? || !valid_file(settings.browser_root, file)
    content = load_file settings.browser_root, file
    return { success: false }.to_json unless file
    return { success: true, content: content}.to_json
  end

end
