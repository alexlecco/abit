class AddPathTypeToHabits < ActiveRecord::Migration[8.1]
  def change
    add_column :habits, :path_type, :string
  end
end
