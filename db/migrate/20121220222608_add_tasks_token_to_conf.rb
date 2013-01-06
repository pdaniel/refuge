class AddTasksTokenToConf < ActiveRecord::Migration
  def change
    add_column :confs, :tasks_token, :string
  end
end
