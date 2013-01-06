task :update_heures => :environment do

  # Update remplitude asking gardien API
  $conf = Conf.find(1)

  puts "#{Time.now} : Requesting gardien for hours..."
  begin
    Gardien::Member.all.each do |member|
      this_member = Member.find_by_gardien_id(member.id)

      if this_member
        this_member.update_attributes({
          :total_heures_guardien => member.total_hours, 
          :total_heures_facturable_guardien => member.billable_hours, 
          :debut_mois_gardien => member.since
        }) 

        puts "Hours for #{member.full_name} : update successfull"
      else
        puts "Unkown gardien_id #{member.id} for #{member.full_name}, skipping"
      end    
    end
  rescue
    # Oooops, gardien is down
    puts "!!! HOURS UPDATE FAILED !!!"
    # !!! TODO : notice admin
  end


end