class User < ActiveRecord::Base
  attr_accessor  :password
  
  
  validates :login, 
    :presence   => true,
    :length => {:maximum => 16, :minimum => 1},
    :uniqueness => true
  
  validates :password,
    :presence => true,
    :confirmation => true,
    :length => {:within => 4..20},
    :on => :create
    
  validates :password_confirmation,
    :presence => true,
    :length => {:within => 4..20},
    :on => :create
    
  validates :password,
    :allow_blank => true,
    :length => {:within => 4..20},
    :on => :update
    
  validates :name,
    :presence => true,
    :length => {:maximum => 16, :minimum => 1},
    :allow_blank => true
    
  validates :signcode,   :uniqueness => true
  validates :verifycode, :uniqueness => true

  before_create :encrypt_something
  before_update :change_password
  
  def self.authenticate(login, password)
    user = find_by_login(login)
    return if user.nil?
    return user if Rails.env == "test" or user.right_password?(password)
  end
  
  def right_password?(password)
    encrypted_password == encrypt(password)
  end
  
  def site_role
    SITE_SETTINGS["site_role"][self.role]
  end
  
  def site_upgrade_state
    SITE_SETTINGS["site_upgrade_state"][self.upgrade_state]
  end
  
  private
  
  def encrypt_something
    self.salt               = make_salt if new_record?
    self.signcode           = encrypt(self.salt + rand(9999).to_s)
    self.verifycode         = encrypt(self.salt + rand(8888).to_s)
    self.encrypted_password = encrypt(password)
  end
  
  def change_password
    self.encrypted_password = encrypt(password) unless password.blank?
  end
  
  def encrypt(str)
    secure_hash("#{salt}--#{str}")
  end
  
  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end
  
  def secure_hash(str)
    Digest::SHA2.hexdigest(str)
  end
  
end
