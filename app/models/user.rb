# Category relations, validations, form macros, updates status before actions
class User < ActiveRecord::Base

  has_secure_password

  has_many :subjects
  has_many :categories, through: :subjects
  has_many :resources
  has_many :ratings

  validates_presence_of :first_name, :last_name, :username, :email

  validates_uniqueness_of :username, :email

  # validates_length_of :password, in: 8..72

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :message => "Invalid email"

  def update_status(user)
    resource_count = Resource.where(user_id: user.id).count
    if resource_count > 2
      user.member_status = "Grand Master"
    elsif resource_count == (1 || 2)
      user.member_status = "Legend"
    elsif resource_count == 0
      user.member_status = "Little Grasshopper"
    end
    user.save
  end

  def self.find_or_creatre_by_omniauth(info)
    @user = User.find_or_create_by(email: info[:email]) do  |user|
      user.first_name ||= info['name'].split(' ')[0]
      user.last_name ||= info['name'].split(' ')[1]
      user.username ||= (user.first_name + user.last_name)
      user.password ||= user.email
    end
    @user.save unless @user.id
    @user
  end


  def class_name
    self.class.name
  end

end
