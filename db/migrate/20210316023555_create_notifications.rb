class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      # 通知を送ったユーザーのid orderクリエイト時に通知を送るイメージ
      t.integer :visitor_id, null: false
      # visited_id : 通知を送られたshopのid
      t.integer :visited_id, null: false
      t.integer :order_id
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end

    add_index :notifications, :visitor_id
    add_index :notifications, :visited_id
  end
end
