class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :user_id, null: false
      t.integer :book_id, null: false
      t.date :order_date, null: false
      t.date :due_date, null: false
      t.date :return_date

      t.timestamps
    end
  end
end
