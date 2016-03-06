class SubjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :updated_at, :class_name, :category_id
  has_many :resources
end
