class Location < ActiveRecord::Base
  has_many :members,  :dependent => :destroy
  has_many :surveys,  :dependent => :destroy
  has_many :articles, :dependent => :destroy
    
  def self.occupation_rates

    @locations = []

    begin
      Gardien::Location.all.each do |location|
        this_location = Location.find_by_refuge_id(location.id)

        rate = (location.members.length.to_f / this_location.max_occupation.to_f)*100.to_f.round(2)

        @locations.push({:id => this_location.id, :name => this_location.name, :occupation => rate})
      end
    rescue
      # Always return a populated/valid hash, even if Gardien is down 
      self.all.each do |location|
        @locations.push({:id => location.id, :name => location.name, :occupation => 0})
      end
    end

    return @locations
  end
end

