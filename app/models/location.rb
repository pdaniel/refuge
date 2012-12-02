class Location < ActiveRecord::Base
  has_many :members, :dependent=>:destroy
  has_many :surveys, :dependent=>:destroy
  has_many :articles, :dependent=>:destroy
    
  def self.occupation_rates

    @locations = []
    Gardien::Location.all.each do |location|
      this_location = Location.find_by_name(location.name)

      rate = (location.members.length.to_f / this_location.max_occupation.to_f)*100.to_f.round(2)

      @locations.push({
        :id => location.id,
        :name => location.name,
        :occupation => rate
      })
    end

    return @locations
  end
end

