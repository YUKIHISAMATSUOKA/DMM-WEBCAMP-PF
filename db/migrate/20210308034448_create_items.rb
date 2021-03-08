class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :shop_id
      t.string :name
      t.integer :price
      t.boolean :sale_state, default: true, null: false
      t.string :image_id
      t.string :introduction
      t.string :genre
      t.string :cook_time

      t.timestamps
    end
  end
end
