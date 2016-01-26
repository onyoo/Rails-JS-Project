class CategoriesController < ApplicationController
  before_action :require_user, only: [:index, :show]

  def new
    @category = Category.new
  end

  def create
    @category = Category.find_or_create_by(category_params)
    redirect_to category_path(@category)
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
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end
