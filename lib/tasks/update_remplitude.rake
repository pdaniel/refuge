task :update_remplitude => :environment do

  # Update remplitude asking gardien API
  $conf = Conf.find(1)

  puts "Updating remplitude..."
  begin
    Gardien::Location.all.each do |location|
      this_location = Location.find_by_refuge_id(location.id)

      rate = (location.members.length.to_f / this_location.max_occupation.to_f)*100.to_f.round(2).to_i

      this_location.update_attributes(:remplitude => rate)
    end
  rescue
    # Oooops, gardien is down
    puts "!!! REMPLITUDE UPDATE FAILED !!!"
    # !!! TODO : notice admin
  end


end