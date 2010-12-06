require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  describe 'Validations' do
    before(:each) do
      @valid_params = {
        :name      => "foo",
        :email     => "bar",
        :password  => "creature"
      }
      @invalid_params = {
      }
    end # before validations

    it "Should be valid with valid params" do
      User.new(@valid_params).valid?.should be_true
    end

    it "Should not be valid with invalid params" do
      User.new(@invalid_params).valid?.should be_false
    end
  end # validations

  describe 'Authenticate' do
    before(:each) do
      @user = User.new
      @email = 'default@default.com'
      @password = 'foobar'
    end
    it "Should return a user if given a valid email/password" do
      User.stub!(:find).and_return(@user)
      User.authenticate(@email, @password).should == @user
    end
    it "Should return nil if email/password doesn't match" do
      User.stub!(:find).and_return(nil)
      User.authenticate(@email, @password).should == nil
    end
      
  end

end # main