class AddActive < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :is_active, :boolean, :default => true
    add_column :books, :is_active, :boolean, :default => true
    end
end
