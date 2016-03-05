class RatingSerializer < ActiveModel::Serializer
  attributes :id, :usability_rating, :addictive_rating
end
