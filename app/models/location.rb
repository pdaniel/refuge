class Location < ActiveRecord::Base
  has_many :members,  :dependent => :destroy
  has_many :surveys,  :dependent => :destroy
  has_many :articles, :dependent => :destroy
    
  def self.update_remplitude
    begin
      Gardien::Location.all.each do |location|
        this_location = self.find_by_refuge_id(location.id)

        rate = (location.members.length.to_f / this_location.max_occupation.to_f)*100.to_f.round(2).to_i

        this_location.update_attributes(:remplitude => rate)
      end
    rescue
      # Oooops, gardien is down
      # !!! TODO : notice admin
    end
  end

end

