class Resource < ActiveRecord::Base

  belongs_to :user
  belongs_to :subject, inverse_of: :resources
  has_one :category, through: :subject
  

  validates_uniqueness_of :name, :url

  validates_presence_of :name, :url, :description, :user_id

  def add_ratings(params,current_user)

      hash_1 = eval(self.addictive_ratings)
      hash_1[current_user.id] = params[:resource][:addictive_ratings].to_i
      self.addictive_ratings = hash_1

      hash_2 = eval(self.usability_ratings)
      hash_2[current_user.id] = params[:resource][:usability_ratings].to_i
      self.usability_ratings = hash_2

      self
  end


end
