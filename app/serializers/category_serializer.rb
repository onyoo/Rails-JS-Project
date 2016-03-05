class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :updated_at, :class_name
  has_many :subjects, :resources
end
