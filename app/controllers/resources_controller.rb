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
    #Avi's suggestion:
      # @resource = Resource.find(params[:id])
      # if @resource.update_from_web(params[:resource])
      #   redirect_telse
      # else
      #   render
      # end
    @resource = Resource.find(params[:id])

    if params[:resource][:name]
      if params[:resource][:_destroy] == "1"
        @resource.destroy
        redirect_to category_subject_path(@subject.category, @subject), notice: "Successfully deleted."
      else

        @resource.update(resource_params)
        redirect_to category_subject_resource_path(@resource.category, @resource.subject, @resource), notice: "Successfully updated. Thanks!"
      end
    elsif addictive_rating || usability_rating
      if @resource.rate_it(params, current_user)
        redirect_to category_subject_resource_path(@resource.category, @resource.subject, @resource), notice: "Thanks for voting!"
      else
        redirect_to :back, notice: "Ratings must be between 1 and 10!"
      end
    end
  end

  def destroy
    @subject = Resource.find(params[:id]).subject
    Resource.delete(params[:id])
  end

  def index
    @resources = Resource.order("name ASC")
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @resources }
    end
  end

  def show
    @resource = Resource.find(params[:id])
    unless @resource.ratings == []
      @usability_rating = (@resource.ratings.map(&:usability_rating).inject(0, :+))/ @resource.ratings.where.not(usability_rating: nil).count
      @addictiveness_rating = (@resource.ratings.map(&:addictive_rating).inject(0, :+))/ @resource.ratings.where.not(addictive_rating: nil).count
    end
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @resource }
    end
  end


  private

  def usability_rating
    params[:resource][:rating][:usability_rating].to_i
  end

  def addictive_rating
    params[:resource][:rating][:addictive_rating].to_i
  end

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
