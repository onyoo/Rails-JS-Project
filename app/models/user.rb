class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :subjects
  has_many :categories, through: :subjects
  has_many :resources

  validates_presence_of :first_name, :last_name, :username





end
