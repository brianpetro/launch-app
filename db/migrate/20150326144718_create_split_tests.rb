class CreateSplitTests < ActiveRecord::Migration
  def change
    create_table :split_tests do |t|
      t.text :javascript
      t.text :note

      t.timestamps null: false
    end
  end
end
