class UpdateUser < ActiveRecord::Migration
  def change
    #user
    add_column :users, :last_login, :datetime
    add_column :users, :error_count, :integer

    #new table
    create_table :secret_questions do |t|
      t.integer :user_id
      t.string :question
      t.string :answer
      t.timestamps null: false
    end

    # list of registrations
    create_table :registration_journals do |t|
      t.string :username
      t.string :password
      t.text :questions, array: true, default: []
      t.timestamps null: false
    end

  end
end
