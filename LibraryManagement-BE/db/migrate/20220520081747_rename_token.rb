class RenameToken < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :authetication_token, :authentication_token
  end
end
