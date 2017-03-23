class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.boolean :admin
      t.string :username
      t.string :password

      t.timestamps null: false
    end
  end
end
