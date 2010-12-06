class User < ActiveRecord::Base
  validates_presence_of :name, :email, :password
  
  def self.authenticate(email, password)
    User.find :first, :conditions => ['email = ? and password = ?', email, password] 
  end
end
