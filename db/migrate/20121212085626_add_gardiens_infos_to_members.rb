class AddGardiensInfosToMembers < ActiveRecord::Migration
  def change
    add_column :members, :gardien_id, :int
    add_column :members, :total_heures_guardien, :float, :default => 0
    add_column :members, :total_heures_facturable_guardien, :float, :default => 0
    add_column :members, :debut_mois_gardien, :date
  end
end
