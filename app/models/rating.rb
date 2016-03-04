class Rating < ActiveRecord::Base
  belongs_to :resource
  belongs_to :user

  validates :user_id, uniqueness: { scope: [:user_id, :resource_id] }
  validates :user_id, uniqueness: { scope: [:user_id, :resource_id] }
  validates_inclusion_of :addictive_rating, in: Array(1..10)
  validates_inclusion_of :usability_rating, in: Array(1..10)
end
