class Subject < ActiveRecord::Base
  belongs_to :user
  has_many :resources, dependent: :destroy, inverse_of: :subject
  belongs_to :category

  validates_presence_of :name, :category, :user #-- tree builder skips user_id assignment even though in nested form. Perhaps because Resource takes one as well?
  validates_uniqueness_of :name

  accepts_nested_attributes_for :resources

  def class_name
    self.class.name
  end

end
