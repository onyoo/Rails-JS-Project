class SubjectsController < ApplicationController
  before_action :require_user, only: [:index, :show]

  def new
    @subject = Subject.new
    @subject.category_id = params[:id]
  end

  def create
    binding.pry
    if Subject.find_by(name: (params[:subject][:name]))
      redirect_to new_subject_path, notice: "That subject seems to exist..."
    else
      @subject = Subject.create(subject_params)
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
    @subject = Subject.find(params[:id])
  end

  private

  def subject_params
    params.require(:subject).permit(:name,:category_id,:user_id)
  end
end
