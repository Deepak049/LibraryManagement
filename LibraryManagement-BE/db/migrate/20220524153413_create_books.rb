class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.integer :isbn, index:{unique: true}, null: false
      t.string :title, null: false
      t.string :author, null: false
      t.string :category
      t.integer :price
      t.integer :fine

      t.timestamps
    end
  end
end
