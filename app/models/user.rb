class User < ActiveRecord::Base 
  has_many :tweets
  has_secure_password
  
  def slug 
    self.username.strip.gsub(' ', '-').gsub(/[^\w-]/, '')    
  end
  
  def self.find_by_slug(slug)
    unslug = slug.gsub('-', ' ')
    User.find_by(username: unslug)
  end
end