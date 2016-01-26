class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to home_path, :notice => "Logged in!"
    else
      redirect_to login_path, notice: "Invalid email or password."
    end 
  end

  def destroy 
    session[:user_id] = nil 
    redirect_to home_path, notice => "Logged out!"
  end


end
