class ImplementRemplitudeCaching < ActiveRecord::Migration
  def up
    add_column :locations, :remplitude, :integer, :default => 0
  end

  def down
  end
end
