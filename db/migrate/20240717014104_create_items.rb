class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :product_name,                   null: false
      t.integer :category_id,                   null: false
      t.integer :price,                         null: false
      t.integer :product_condition_id,          null: false
      t.integer :burden_of_shipping_charges_id, null: false
      t.integer :delivery_region_id,            null: false
      t.integer :estimated_delivery_date_id,    null: false
      t.text :product_description,              null: false
      t.references :user,                       null: false, foreign_key: true
      t.timestamps
    end
  end
end
