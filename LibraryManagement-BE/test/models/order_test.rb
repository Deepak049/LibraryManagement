require "test_helper"

class OrderTest < ActiveSupport::TestCase
    setup do
        @user = users(:user)
        @book = books(:one)
    end

    test "should not create orders without user and book" do
        order = Order.new()
        assert_not(order.save, "Order is saved without details")
    end

    test "should not create orders without order_date and due_date" do
        order = Order.new(user_id: @user.id, book_id: @book.id)
        assert_not(order.save, "Order is saved with order_date and due_date")
    end

    test "should create orders with proper details" do
        order = Order.new(user_id: @user.id, book_id: @book.id, order_date: Date.today, due_date: Date.today)
        assert(order.save, "Order is not saved with proper details")
    end

    test "should not create order without proper user id" do
        order = Order.new(user_id: 12, book_id: @book.id, order_date: Date.today, due_date: Date.today)
        assert_not(order.save, "Order is saved without proper user id")
    end

    test "should not create order without proper book id" do
        order = Order.new(user_id: @user.id, book_id: 12, order_date: Date.today, due_date: Date.today)
        assert_not(order.save, "Order is saved without proper book id")
    end
end