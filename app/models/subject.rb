class Subject < ActiveRecord::Base
  belongs_to :user
  has_many :resources
  belongs_to :category

end
