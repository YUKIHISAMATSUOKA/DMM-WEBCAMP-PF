class CreateShops < ActiveRecord::Migration[5.2]
  def change
    create_table :shops do |t|
      t.integer :customer_id
      t.integer :area_id
      t.string :name
      t.text :introduction
      t.string :image_id
      t.boolean :status, default: true, null: false
      t.string :address
      t.string :telephone_number
      t.string :post_code
      t.string :email

      t.timestamps
    end
  end
end
