class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def create
    redirect to category_path(Category.create(category_params))
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])

    @category.update(category_params)

    redirect_to category_path(@category)
  end

  def destroy
    binding.pry
    Category.destroy(params[:id])
  end

  def index
  end

  def show
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end
