class UsersController < ApplicationController
  layout 'main'
  def login
    @user = User.new
  end
  def authenticate
    email = params[:user][:email]
    password = params[:user][:password]
    @user = User.authenticate(email, password)
    if @user
      redirect_to '/'
    else
      flash[:error] = 'Incorrect email and/or password'
      render :login
    end
  end
end
