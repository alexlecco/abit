class CreateActivities < ActiveRecord::Migration[8.1]
  def change
    create_table :activities do |t|
      t.references :habit, null: false, foreign_key: true
      t.string :title, null: false
      t.integer :position, null: false, default: 0
      t.timestamps
    end
  end
end
