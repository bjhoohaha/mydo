class AddTimeLeftToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :time_left, :integer
  end
end
