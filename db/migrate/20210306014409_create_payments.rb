class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.integer :shop_id
      t.string :name
      t.string :image_id
      t.string :genre

      t.timestamps
    end
  end
end
