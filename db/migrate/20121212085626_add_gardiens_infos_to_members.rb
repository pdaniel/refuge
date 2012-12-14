class AddGardiensInfosToMembers < ActiveRecord::Migration
  def change
    add_column :members, :total_heures_guardien, :float
    add_column :members, :total_heures_facturable_guardien, :float
    add_column :members, :debut_mois_gardien, :date
  end
end
