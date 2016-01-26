class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create 
    @user = User.new(user_params) 
    binding.pry
    if @user.save 
      session[:user_id] = @user.id 
      redirect_to '/home' 
    else 
      redirect_to "/users/new"
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
