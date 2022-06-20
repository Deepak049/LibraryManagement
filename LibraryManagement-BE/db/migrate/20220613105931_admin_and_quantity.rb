class AdminAndQuantity < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :is_admin, :boolean, :default => false
    add_column :books, :quantity, :integer, :default => 1
  end
end
