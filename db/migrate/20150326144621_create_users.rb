class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.boolean :confirmed
      t.string :tracker
      t.integer :split_test_id

      t.timestamps null: false
    end
  end
end
