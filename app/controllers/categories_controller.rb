class CategoriesController < ApplicationController
  before_action :require_user, only: [:index, :show]

  def new
    @category = Category.new
  end

  def create
    if Category.find_by(name: params[:name])
      redirect_to new_category_path, notice: "That category seems to exist..."
    else
      @category = Category.create(category_params)
      redirect_to category_path(@category)
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    if params[:category][:_destroy] == "1"
      destroy
      redirect_to categories_path
    else
      @category = Category.find(params[:id])
      @category.update(category_params)
      redirect_to category_path(@category)
    end
  end

  def destroy
    Category.destroy(params[:id])
  end

  def index
    @categories = Category.order("name ASC")
  end

  def show
    @category = Category.find(params[:id])
  end


  def plant_tree
    @category = Category.new
    subject = @category.subjects.build
    subject.resources.build
    @categories = Category.all
    @subjects = Subject.all
    render 'new'
  end

  def grow_tree
    Category.create_correct_associations(params)
    binding.pry
    if errors.messages.empty?
      redirect_to resource_path(@resource = Resource.last)
    else
      render 'new', notice: "You F-ed-up"
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def tree_params_old_cat
    params.require(:category).permit(:id, :subjects_attributes => [:name, :user_id, :resources_attributes => [:name,:url,:description,:subject_id, :user_id, :price_per_month]])
  end
    
  def tree_params_old_cat_old_sub
    params.require(:category).permit(:id, :subjects_attributes => [:user_id, :id, :resources_attributes => [:name,:url,:description,:subject_id, :user_id, :price_per_month]])
  end

  def tree_params_new_cat_and_new_sub
    params.require(:category).permit(:name, :subjects_attributes => [:name, :user_id, :resources_attributes => [:name,:url,:description,:subject_id, :user_id, :price_per_month]])
  end

end
