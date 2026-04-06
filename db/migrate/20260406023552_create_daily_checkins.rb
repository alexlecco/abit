class CreateDailyCheckins < ActiveRecord::Migration[8.1]
  def change
    create_table :daily_checkins do |t|
      t.references :habit, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.date :checked_on, null: false
      t.integer :progress_score, null: false
      t.text :notes
      t.timestamps
    end

    add_index :daily_checkins, [ :habit_id, :checked_on ], unique: true
    add_index :daily_checkins, [ :habit_id, :user_id, :checked_on ]
  end
end
