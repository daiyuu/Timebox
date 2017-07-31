class AddCounterToContent < ActiveRecord::Migration
  def change
    add_column :contents, :counter, :integer, default: 0
  end
end
