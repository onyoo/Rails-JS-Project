class Subject < ActiveRecord::Base
  belongs_to :user
  has_many :resources
  belongs_to :category

  validates_presence_of :name, :user_id, :category_id

end
