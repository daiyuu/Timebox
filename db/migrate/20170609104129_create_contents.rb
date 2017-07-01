class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :thumbnail
      t.string :url

      t.timestamps null: false
    end
  end
end
