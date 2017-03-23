class CreateActionJournals < ActiveRecord::Migration
  def change
    create_table :action_journals do |t|
      t.integer :user_id
      t.integer :danger_level
      t.text :comment

      t.timestamps null: false
    end
  end
end
