require File.dirname(__FILE__) + '/../spec_helper'

describe UsersController do
  describe 'login' do
    it 'There should be a login page' do
      get :login
      assigns(:user).should_not be_nil
    end
  end

  describe 'Logging out' do
    before(:each) do
      @user = User.new
      @user.stub!(:id).and_return(1)
      session[:user_id] = @user.id
    end
    it 'should log you out' do
      get :logout
      session[:user_id].should == nil
      response.should redirect_to login_users_path
    end
  end # logout 

  describe 'authenticate' do
    before(:each) do
      @user = User.new
      @user.stub!(:id).and_return(1)
    end
    it 'Should route successful login to /' do
      User.stub(:authenticate).and_return @user
      post :authenticate, :user => {:email => @user.email, :password => @user.password}
      session[:user_id].should == @user.id
      response.should redirect_to '/'
    end
    it 'Should route unsuccessful login to login page, and flash error' do
      User.stub(:authenticate).and_return nil
      post :authenticate, :user => {:email => @user.email, :password => @user.password}
      response.should_not redirect_to '/'
      flash[:error].should_not be_nil
    end
  end
end #main describe
