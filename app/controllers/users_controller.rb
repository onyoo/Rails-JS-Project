class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if @user = User.find_by(params[:username])
      redirect_to new_user_path                  #### need error messages
    else
      @user = User.create(user_params)
      redirect_to user_path(@user)
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def index
  end

  def show
  end

  private

  def user_params
    params.require(:user).permit(:first_name,:last_name,:email,:password,:username)
  end
end
