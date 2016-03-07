class TreeBuildersController < ApplicationController

  def new
    @category = Category.new
    subject = @category.subjects.build
    subject.resources.build
    @categories = Category.all
    @subjects = Subject.all
    respond_to do |format|
      format.html { render 'new' }
      format.json { render '_tree_builder', layout: false }
    end
  end

  def create
    if TreeBuilder.create_correct_associations(params)
      @resource = Resource.last
      respond_to do |format|
        format.html { redirect_to category_subject_resource_path(@resource.category, @resource.subject, @resource), message: "Masterful creation!" }
        format.json { render json: @resource }
      end
    else
      redirect_to tree_path, message: "There was a problem"
    end
  end

end
