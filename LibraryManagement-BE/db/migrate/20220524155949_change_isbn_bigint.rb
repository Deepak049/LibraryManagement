class ChangeIsbnBigint < ActiveRecord::Migration[7.0]
  def change
    change_column :books, :isbn, :bigint
  end
end
