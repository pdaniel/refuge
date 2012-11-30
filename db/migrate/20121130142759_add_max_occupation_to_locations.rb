class AddMaxOccupationToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :max_occupation, :integer, default: 20
  end
end
