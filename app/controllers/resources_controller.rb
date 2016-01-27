class ResourcesController < ApplicationController
  before_action :require_user, only: [:index, :show]
  
  def new
    @resource = Resource.new
    @resource.subject_id = params[:subject_id]
  end

  def create
    if Resource.find_by(name: (params[:resource][:name]))
      redirect_to new_resource_path, notice: "That resource seems to exist..."
    else
      @resource = Resource.create(resource_params)
      redirect_to resource_path(@resource)
    end
  end

  def edit
    @resource = Resource.find(params[:id])
  end

  def update
    if params[:resource][:name]
      if params[:resource][:_destroy] == "1"
        destroy
        redirect_to subject_path(@subject)
      else
        @resource = Resource.find(params[:id])
        @resource.update(resource_params)
        redirect_to resource_path(@resource)
      end
    elsif params[:resource][:usability_rating]
      @resource = Resource.find(params[:id])
      @resource.update(resource_rating_params)
      redirect_to resource_path(@resource)
    end
  end

  def destroy
    @subject = Resource.find(params[:id]).subject
    Resource.delete(params[:id])
  end

  def index
  end

  def show
    @resource = Resource.find(params[:id])
  end

  private

  def resource_params
    params.require(:resource).permit(:name,:url,:description,:subject_id, :user_id, :price_per_month)
  end

  def resource_rating_params
    params.require(:resource).permit(:usability_rating,:addictive_rating)
  end
end
