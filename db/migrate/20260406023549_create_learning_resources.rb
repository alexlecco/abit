class CreateLearningResources < ActiveRecord::Migration[8.1]
  def change
    create_table :learning_resources do |t|
      t.references :habit, null: false, foreign_key: true
      t.string :title, null: false
      t.string :url
      t.string :resource_type, null: false
      t.integer :week_number, null: false
      t.integer :position, null: false, default: 0
      t.datetime :completed_at
      t.text :notes
      t.timestamps
    end

    add_index :learning_resources, [ :habit_id, :week_number ]
  end
end
