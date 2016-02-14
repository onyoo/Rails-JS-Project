class SessionsController < ApplicationController

  def new
  end

  def create
    if request.env['omniauth.auth']
      @user = User.find_or_create_by(email: auth[:info][:email]) do  |user|
        user.first_name ||= auth['info']['name'].split(' ')[0]
        user.last_name ||= auth['info']['name'].split(' ')[1]
        user.username ||= (user.first_name + user.last_name)
        user.password ||= user.email
      end
      @user.save unless @user.id
      session[:user_id] = @user.id
    else
      @user = User.find_by_email(params[:session][:email])
      if @user && @user.authenticate(params[:session][:password])
        session[:user_id] = @user.id
      else
        bidning.pry
        redirect_to login_path, notice: "Invalid email or password."
      end
    end 
    redirect_to home_path, :notice => "Logged in!"
  end

  def destroy 
    session[:user_id] = nil 
    redirect_to home_path, notice => "Logged out!"
  end

  private

  def auth
    request.env['omniauth.auth']
  end


end
