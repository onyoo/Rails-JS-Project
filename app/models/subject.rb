class Subject < ActiveRecord::Base
  belongs_to :user
  has_many :resources
  has_many :subjects
  has_many :categories, through: :subjects

end
