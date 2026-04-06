class CreateActivityCompletions < ActiveRecord::Migration[8.1]
  def change
    create_table :activity_completions do |t|
      t.references :activity, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.date :completed_on, null: false
      t.timestamps
    end

    add_index :activity_completions, [ :activity_id, :completed_on ], unique: true
    add_index :activity_completions, [ :activity_id, :user_id, :completed_on ]
  end
end
