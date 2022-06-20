class AddWalletAndDesc < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :wallet, :bigint, :null => false, :default => 10000
    add_column :books, :description, :text
  end
end
