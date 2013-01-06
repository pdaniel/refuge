class Menu < ActiveRecord::Base

  scope :published, self.where('published = true') 
  
end

