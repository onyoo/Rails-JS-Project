class Subject < ActiveRecord::Base
  belongs_to :user
  has_many :resources, dependent: :destroy, inverse_of: :subject
  belongs_to :category

  # validates_presence_of :name, :category_id, :user_id
  # validates_uniqueness_of :name

  accepts_nested_attributes_for :resources


end
