class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name,null: false
      t.text :description,null: false
      t.integer :price,null: false
      t.string :condition,null: false
      t.string :shipping_method,null: false
      t.string :shipping_date,null: false
      t.string :shipping_fee,null: false
      t.integer :prefecture_id,null: false
      t.string :brand
      t.integer :size_id
      t.references :category,foreign_key: true
      # t.references :user,foreign_key: true
      # t.references :vendor,foreign_key: true
      t.timestamps
    end
  end
end
