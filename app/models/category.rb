class Category < ActiveRecord::Base
  has_many :subjects, dependent: :destroy, inverse_of: :category
  has_many :users, through: :subjects
  has_many :resources, through: :subjects, dependent: :destroy

  validates_presence_of :name
  validates_uniqueness_of :name

  accepts_nested_attributes_for :subjects

  def self.create_correct_associations(params)
    if (params[:category][:id] != "") && (params[:category][:subjects_attributes]["0"][:id] == "")
      Category.create_with_new_subject(tree_params_old_cat(params))
    elsif (params[:category][:id] != "") && (params[:category][:subjects_attributes]["0"][:id] != "")
      Category.create_tree(tree_params_old_cat_old_sub(params))
    else
      Category.create_with_new_category_and_subject(tree_params_new_cat_and_new_sub(params))
    end
  end

  def self.create_tree(tree_params)
    @subject = Subject.find(tree_params[:subjects_attributes]["0"][:id])
    @subject.resources.create(tree_params[:subjects_attributes]["0"][:resources_attributes]["0"])
  end

  def self.create_with_new_subject(tree_params)
    @subject = Subject.create(tree_params[:subjects_attributes]["0"])
    @subject.category_id = Category.find(tree_params[:id]).id
    @subject.resources[0].subject_id = @subject.id
    @subject.save
  end

  def self.create_with_new_category_and_subject(tree_params)
    @category = Category.create(tree_params)
  end




  def self.tree_params_old_cat(params)
    params.require(:category).permit(:id, :subjects_attributes => [:name, :user_id, :resources_attributes => [:name,:url,:description,:subject_id, :user_id, :price_per_month]])
  end

  def self.tree_params_old_cat_old_sub(params)
    params.require(:category).permit(:id, :subjects_attributes => [:user_id, :id, :resources_attributes => [:name,:url,:description,:subject_id, :user_id, :price_per_month]])
  end

  def self.tree_params_new_cat_and_new_sub(params)
    params.require(:category).permit(:name, :subjects_attributes => [:name, :user_id, :resources_attributes => [:name,:url,:description,:subject_id, :user_id, :price_per_month]])
  end
end
