class SessionsController < ApplicationController

  def new
  end

  def create
    if request.env['omniauth.auth']
      @user = User.find_or_creatre_by_omniauth(request.env['omniauth.auth']['info'])
      session[:user_id] = @user.id
      redirect_to home_path, :notice => "Logged in!"
    else
      @user = User.find_by_email(params[:session][:email])
      if @user && @user.authenticate(params[:session][:password])
        session[:user_id] = @user.id
        redirect_to home_path, :notice => "Logged in!"
      else
        redirect_to login_path, notice: "Invalid email or password."
      end
    end
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
