task :update_heures => :environment do

  # Update remplitude asking gardien API
  $conf = Conf.find(1)

  puts "Updating heures..."
  begin
    Gardien::Members.all.each do |member|
      this_member = Member.find_by_refuge_id(member.id)

      this_member.update_attributes({:total_heures_guardien => member.total_hours, :total_heures_facturable_guardien => member.billable_hours, :debut_mois_gardien => member.since}) if this_member
    end
  rescue
    # Oooops, gardien is down
    puts "!!! HEURES UPDATE FAILED !!!"
    # !!! TODO : notice admin
  end


end