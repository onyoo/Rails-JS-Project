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
      redirect_to category_path(@category), notice: "Successfully created!"
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    if params[:category][:_destroy] == "1"
      destroy
      redirect_to categories_path, notice: "Successfully deleted."
    else
      @category = Category.find(params[:id])
      @category.update(category_params)
      redirect_to category_path(@category), notice: "Successfully updated. Thanks!"
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
    if Category.create_correct_associations(params)
      @resource = Resource.last
      redirect_to category_subject_resource_path(@resource.category, @resource.subject, @resource), message: "Masterful creation!"
    else
      redirect_to tree_path, message: "There was a problem"
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end



end
