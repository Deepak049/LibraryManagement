class OrderSerializer < ActiveModel::Serializer
    attributes :id, :user_id, :book_id, :order_date, :due_date, :return_date
  end