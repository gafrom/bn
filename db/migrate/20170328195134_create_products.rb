class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :slug
      t.string :url
      t.string :title
      t.string :brand
      t.string :vendor
      t.string :category
      t.string :tags
      t.integer :remote_id
      t.integer :weight
      t.integer :price
      t.integer :compare_price
      t.string :images, array: true, default: []

      t.timestamps
    end
  end
end
