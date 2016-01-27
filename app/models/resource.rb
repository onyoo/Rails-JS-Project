class Resource < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  has_one :category, through: :subject
  

  validates_uniqueness_of :name, :url

  validates_presence_of :name, :url, :description, :user_id
end
