class Order < ApplicationRecord
    validates :user_id, :book_id, :order_date, :due_date, presence: true

    belongs_to :user
    belongs_to :book
end