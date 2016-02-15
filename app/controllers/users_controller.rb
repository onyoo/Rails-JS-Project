class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create 
    @user = User.new(user_params) 
    if @user.save 
      session[:user_id] = @user.id 
      redirect_to home_path
    else 
      render new_user_path
    end 
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if params[:user][:_destroy] == "1"
      destroy
      redirect_to home_path
    else
      @user = User.find(params[:id])
      if @user.update(edit_user_params)
        redirect_to user_path(@user), message: "Profile updated."
      else
        render :edit
      end
    end
  end

  def index
    @users = User.all
  end

  def show
    unless current_user
      redirect_to(:back)
    end
    @user = User.find(params[:id])
  end

  def new_password
    @user = User.find(params[:id])
  end

  def post_password
    if @user.update(password_params)
      redirect_to user_path(@user), message: "Password updated."
    else
      render :new_password
    end
  end

  private

  def password_params
    params.require(:user).permit(:password)
  end

  def edit_user_params
    params.require(:user).permit(:first_name,:last_name,:email,:username)
  end

  def user_params
    params.require(:user).permit(:first_name,:last_name,:email,:username,:password)
  end

end
