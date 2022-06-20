class AddTokenToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :authentication_token, :string
    drop_table :users_tables
  end
end
