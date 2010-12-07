class UsersController < ApplicationController
  layout 'main'
  def login
    @user = User.new
  end
  def logout
    session[:user_id] = nil
    @current_user = nil
    redirect_to login_users_path
  end
  def authenticate
    email = params[:user][:email]
    password = params[:user][:password]
    @user = User.authenticate(email, password)
    if @user
      session[:user_id] = @user.id
      redirect_to '/'
    else
      flash[:error] = 'Incorrect email and/or password'
      render :login
    end
  end
end
