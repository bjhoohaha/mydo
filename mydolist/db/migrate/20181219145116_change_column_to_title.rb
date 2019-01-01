class ChangeColumnToTitle < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :title, :string
    remove_column :tasks, :name, :string
  end
end
