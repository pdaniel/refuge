class AddRefugeIdToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :refuge_id, :integer
    add_index :locations, :refuge_id
    
    add_column :members, :refuge_id, :integer
    add_index :members, :refuge_id
  end
end
