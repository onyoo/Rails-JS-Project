class User < ActiveRecord::Base
         
  has_secure_password

  has_many :subjects
  has_many :categories, through: :subjects
  has_many :resources

  validates_presence_of :first_name, :last_name, :username, :email

  validates_uniqueness_of :username

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :message => "Invalid email"

end
