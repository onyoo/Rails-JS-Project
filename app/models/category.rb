class Category < ActiveRecord::Base
  has_many :subjects, dependent: :destroy, inverse_of: :category
  has_many :users, through: :subjects
  has_many :resources, through: :subjects, dependent: :destroy

  validates_presence_of :name
  validates_uniqueness_of :name

  accepts_nested_attributes_for :subjects

  def self.create_tree(tree_params)
    @resource = Resource.create(tree_params[:subjects_attributes]["0"][:resources_attributes]["0"])
    @subject = Subject.find(tree_params[:subjects_attributes]["0"][:id])
    @subject.resources << @resource
    @subject.save
  end

  def self.create_with_new_subject(tree_params)
    @subject = Subject.create(tree_params[:subjects_attributes]["0"])
    @subject.category_id = Category.find(tree_params[:id]).id
    @subject.resources[0].subject_id = @subject.id
    @subject.save
    binding.pry
  end

  def self.create_with_new_category_and_subject(tree_params)
    @category = Category.create(tree_params)
  end


end
