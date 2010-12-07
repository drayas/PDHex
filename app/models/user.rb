class User < ActiveRecord::Base
  validates_presence_of :name, :email, :password
  has_many :game_users
  has_many :games, :through => :game_users
  
  def self.authenticate(email, password)
    User.find :first, :conditions => ['email = ? and password = ?', email, password] 
  end
end
