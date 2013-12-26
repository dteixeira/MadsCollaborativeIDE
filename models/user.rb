class User

  include DataMapper::Resource
  attr_accessor :password, :confirm_password

  # Filters.
  before :save, :encrypt_password

  # Database fields.
  property :id, Serial

  property :username, String,
    :required => true,
    :length => 5..256,
    :unique => true

  property :email, String,
    :required => true,
    :format => :email_address,
    :unique => true

  property :password_hash, String,
    :required => true

  property :password_salt, String,
    :required => true

  property :created_at, DateTime

  # Outside validations.
  validates_presence_of :password, :confirm_password,
    :messages => { :presence => "You have to type a password and confirm it." }

  # Helper methods.
  private
  def encrypt_password
    if password != nil && password == confirm_password
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret password, password_salt
    end
  end

end
