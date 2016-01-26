class SubjectsController < ApplicationController
  before_action :require_user, only: [:index, :show]

  def new
    @subject = Subject.new
    @subject.category_id = params[:id]
  end

  def create
    binding.pry
    if @subject = Subject.find_by(params[:subject][:name])
      redirect_to subject_path(@subject)
    else
      @subject = Subject.find_or_create_by(subject_params)
      redirect_to subject_path(@subject)
    end
  end

  def edit
    @subject = Subject.find(params[:id])
  end

  def update
    @subject = Subject.find(params[:id])

    @subject.update(subject_params)

    redirect_to subject_path(@subject)
  end

  def destroy
    binding.pry
    Subject.destroy(params[:id])
  end

  def index
    @subjects = Subject.all
  end

  def show
    @subjects = Subject.all
  end

  private

  def subject_params
    params.require(:subject).permit(:name,:category_id)
  end
end
