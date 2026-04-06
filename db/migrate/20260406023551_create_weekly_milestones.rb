class CreateWeeklyMilestones < ActiveRecord::Migration[8.1]
  def change
    create_table :weekly_milestones do |t|
      t.references :goal, null: false, foreign_key: true
      t.integer :week_number, null: false
      t.string :description, null: false
      t.text :acceptance_criteria
      t.boolean :achieved, null: false, default: false
      t.datetime :achieved_at
      t.text :reflection
      t.timestamps
    end

    add_index :weekly_milestones, [ :goal_id, :week_number ], unique: true
  end
end
