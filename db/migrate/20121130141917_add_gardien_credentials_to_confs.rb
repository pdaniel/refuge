class AddGardienCredentialsToConfs < ActiveRecord::Migration
  def change
    add_column :confs, :gardien_login, :string
    add_column :confs, :gardien_password, :string
  end
end
