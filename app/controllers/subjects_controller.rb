class SubjectsController < ApplicationController
  before_action :require_user, only: [:index, :show]

  def new
    new_subject_with_cat
  end

  def create
    if Subject.find_by(name: (params[:subject][:name]))
      redirect_to new_category_subject_path, notice: "That subject seems to exist..."
    elsif params[:subject][:name] == ''
      redirect_to new_category_subject_path, notice: "Must provide a name."
    else
      @subject = Subject.create(subject_params)
      if category_id_params
        @subject.update(category_id: category_id_params, user_id: current_user.id)
      end
      redirect_to category_subject_path(@subject.category, @subject)
    end
  end

  def edit
    @subject = Subject.find(params[:id])
  end

  def update
    if params[:subject][:_destroy] == "1"
      destroy
      redirect_to category_path(@category)
    else
      @subject = Subject.find(params[:id])
      @subject.update(subject_params)
      redirect_to category_subject_path(@subject.category, @subject)
    end
  end

  def destroy
    @category = Subject.find(params[:id]).category
    Subject.destroy(params[:id])
  end

  def index
    new_subject_with_cat
    @subjects = Subject.order("name ASC")
  end

  def show
    @subject = Subject.find(params[:id])
  end


  private

  def new_subject_with_cat
    @subject = Subject.new
    @subject.category_id = (params[:category_id] || params[:id])
  end

  def subject_params
    params.require(:subject).permit(:name,:category_id,:user_id)
  end

  def category_id_params
    params[:subject][:category_id].to_i
  end
end
