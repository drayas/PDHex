require File.dirname(__FILE__) + '/../spec_helper'

describe UsersController do
  describe 'login' do
    it 'There should be a login page' do
      get :login
      assigns(:user).should_not be_nil
    end
  end
  describe 'authenticate' do
    before(:each) do
      @user = User.new
    end
    it 'Should route successful login to /' do
      User.stub(:authenticate).and_return @user
      post :authenticate, :user => {:email => @user.email, :password => @user.password}
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
