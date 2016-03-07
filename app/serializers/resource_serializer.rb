class ResourceSerializer < ActiveModel::Serializer
  attributes :id, :name, :url, :description, :price_per_month, :updated_at, :class_name, :subject_id, :category
  has_many :ratings
end
