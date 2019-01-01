class AddColorToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :color, :string
  end
end
