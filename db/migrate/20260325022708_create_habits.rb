class CreateHabits < ActiveRecord::Migration[8.1]
  def change
    create_table :habits do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.string :color, default: "#14B8A6"
      t.integer :position, default: 0
      t.boolean :active, default: true, null: false
      t.date :start_date
      t.integer :current_streak, default: 0, null: false
      t.integer :longest_streak, default: 0, null: false

      t.timestamps
    end
  end
end
