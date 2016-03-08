# Manages coordination of logic between views and model for categories
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
    binding.pry
    if params[:category][:_destroy] == "1"
      destroy
      redirect_to categories_path, notice: "Successfully deleted."
    else
      @category = Category.find(params[:id])
      @category.update(category_params)
      respond_to do |format|
        format.html { redirect_to category_path(@category), notice: "Successfully updated. Thanks!" }
        format.json { render json: @category }
      end
    end
  end

  def destroy
    Category.destroy(params[:id])
    redirect_to categories_path
  end

  def index
    @categories = Category.order("name ASC")
    respond_to do |format|
      format.html { render :index };
      format.json { render json: @categories }
    end
  end

  def show
    @category = Category.find(params[:id])
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @category }
    end
  end



  private

  def category_params
    params.require(:category).permit(:name)
  end



end
