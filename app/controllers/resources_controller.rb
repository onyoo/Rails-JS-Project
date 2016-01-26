class ResourcesController < ApplicationController
  before_action :require_user, only: [:index, :show]
  
  def new
    @resource = Resource.new
    @resource.subject_id = params[:subject_id]
  end

  def create
    @resource = Resource.find_or_create_by(resource_params)
    redirect_to resource_path(@resource)
  end

  def edit
    @resource = Resource.find(params[:id])
  end

  def update
    @resource = Resource.find(params[:id])
  end

  def destroy
  end

  def index
  end

  def show
    @resource = Resource.find(params[:id])
  end

  private

  def resource_params
    params.require(:resource).permit(:name,:url,:description,:subject_id)
  end
end
