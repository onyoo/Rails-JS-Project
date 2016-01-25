class SubjectsController < ApplicationController
  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.find_or_create_by(subject_params)
    redirect_to subject_path(@subject)
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
    params.require(:subject).permit(:name)
  end
end
