class Category < ActiveRecord::Base
  has_many :subjects
  has_many :users, through: :subjects
  has_many :resources, through: :subjects

  validates_presence_of :name
  validates_uniqueness_of :name

  accepts_nested_attributes_for :subjects

end
