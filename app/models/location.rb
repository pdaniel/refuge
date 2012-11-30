class Location < ActiveRecord::Base
  has_many :members, :dependent=>:destroy
  has_many :surveys, :dependent=>:destroy
  has_many :articles, :dependent=>:destroy
  
  
  def current_occupation_rate
    return (100*occupation/max_occupation).round if max_occupation
    -1
  end
end

