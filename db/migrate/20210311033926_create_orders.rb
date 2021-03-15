class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.integer :shop_id
      t.integer :billing_amount
      t.integer :status
      t.text :request
      t.string :number
      t.time :pick_up_time
      t.string :name

      t.timestamps
    end
  end
end
