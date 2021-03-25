class CreateOrderComments < ActiveRecord::Migration[5.2]
  def change
    create_table :order_comments do |t|
      t.integer :order_id
      t.integer :customer_id
      t.integer :shop_id
      t.text :comment

      t.timestamps
    end
  end
end
