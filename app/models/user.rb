class User < ActiveRecord::Base
  has_many :subjects
  has_many :categories, through: :subjects
  has_many :resources
end
