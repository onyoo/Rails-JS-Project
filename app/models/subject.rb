class Subject < ActiveRecord::Base
  belongs_to :user
  has_many :resources, dependent: :destroy
  belongs_to :category

  validates_presence_of :name, :category_id, :user_id
  validates_uniqueness_of :name

end
