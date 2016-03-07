class Resource < ActiveRecord::Base

  belongs_to :user
  belongs_to :subject, inverse_of: :resources
  has_one :category, through: :subject
  has_many :ratings

  validates_uniqueness_of :name, :url
  validates_presence_of :name, :url, :description, :user_id

  accepts_nested_attributes_for :ratings

  def rate_it(params, user)
    rating = Rating.find_or_create_by( user_id: user.id, resource_id: self.id )
    rating.update(usability_rating: params[:resource][:rating][:usability_rating], addictive_rating: params[:resource][:rating][:addictive_rating])
  end

  def class_name
    self.class.name
  end

end
