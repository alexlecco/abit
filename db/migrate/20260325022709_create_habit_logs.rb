class CreateHabitLogs < ActiveRecord::Migration[8.1]
  def change
    create_table :habit_logs do |t|
      t.references :habit, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.date :completed_on
      t.text :notes

      t.timestamps
    end

    add_index :habit_logs, [ :habit_id, :completed_on ], unique: true
    add_index :habit_logs, [ :user_id, :completed_on ]
  end
end
