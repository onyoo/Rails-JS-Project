class ResourcesController < ApplicationController
  before_action :require_user, only: [:index, :show]
  
  def new
    @resource = Resource.new
    @resource.subject_id = params[:subject_id]
  end

  def create
    if @resource = Resource.find_by(name: (params[:resource][:name]))
      redirect_to new_resource_path(new_resource_hash), notice: "That resource seems to exist..."
    else
      @resource = Resource.create(resource_params)
      redirect_to category_subject_resource_path(@resource.category, @resource.subject, @resource), notice: "Successfully created!"
    end
  end

  def edit
    @resource = Resource.find(params[:id])
  end

  def update
    if params[:resource][:name]
      if params[:resource][:_destroy] == "1"
        destroy
        redirect_to category_subject_path(@subject.category, @subject), notice: "Successfully deleted."
      else
        @resource = Resource.find(params[:id])
        @resource.update(resource_params)
        redirect_to category_subject_resource_path(@resource.category, @resource.subject, @resource), notice: "Successfully updated. Thanks!"
      end
    elsif params[:resource][:addictive_ratings] || params[:resource][:usability_ratings]
      @resource = Resource.find(params[:id])

      @resource.add_ratings(params, current_user).save
      redirect_to category_subject_resource_path(@resource.category, @resource.subject, @resource), notice: "Thanks for voting!"
    end
  end

  def destroy
    @subject = Resource.find(params[:id]).subject
    Resource.delete(params[:id])
  end

  def index
    @resources = Resource.order("name ASC")
  end

  def show
    @resource = Resource.find(params[:id])
  end


  private

  def resource_params
    params.require(:resource).permit(:name,:url,:description,:subject_id, :user_id, :price_per_month)
  end

  def new_resource_hash
        {
        controller: "resources",
        action: "new",
        category_id: @resource.category.id,
        subject_id: @resource.subject.id
      }
  end

end
