class Project

  include DataMapper::Resource

  property :id, Serial

  property :name, String,
    :required => true,
    :unique => true,
    :length => 5..128

  property :repo_url, String,
    :required => true,
    :length => 20..512,
    :format => :url

  belongs_to :user
end
