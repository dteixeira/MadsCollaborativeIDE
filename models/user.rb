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
    :required => true,
    :length => 20..256

  property :password_salt, String,
    :required => true,
    :length => 20..256

  property :created_at, DateTime

  # Outside validations.
  validates_presence_of :password, :confirm_password,
    :messages => { :presence => "You have to type a password and confirm it." }

  # Validation methods.
  def self.login user
    begin
      u = User.first(:username, user['username'])
      u.password = user['password']
      hash = BCrypt::Engine.hash_secret u.password, u.password_salt
      u = nil unless hash == u.password_hash
      return u
    rescue Exception => e
      puts e
      return nil
    end
  end

  def save
    encrypt_password
    super
  end

  # Helper methods.
  def encrypt_password
    if password != nil && password == confirm_password
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret password, password_salt
    end
  end

end
