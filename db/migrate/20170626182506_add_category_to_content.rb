class AddCategoryToContent < ActiveRecord::Migration
  def change
    add_column :contents, :category, :string
  end
end
