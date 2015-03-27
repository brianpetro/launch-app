class AddActiveToSplitTests < ActiveRecord::Migration
  def change
    add_column :split_tests, :active, :boolean
  end
end
