require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = users(:user)
    @user = users(:not_admin)
    @order = orders(:one)
    @book = books(:three)
  end

  # show action
  test "should show only user's order on show url" do
    order = Order.new(user_id: 1, book_id: 1, order_date: Date.today, due_date: Date.today)
    order.save
    get order_url(order), headers: {:Authorization => "Bearer #{@user.authentication_token}, email=#{@user.email}"}
    assert_response 400
    json_response = JSON.parse(response.body)
    assert_equal(json_response["errors"], "Unauthorized")
  end

  test "should show orders to admin" do
    get order_url(@order), headers: {:Authorization => "Bearer #{@admin_user.authentication_token}, email=#{@admin_user.email}"}
    assert_response 200
    json_response = JSON.parse(response.body)
    assert_equal(json_response["order"]["id"], 1)
  end

  # index action
  test "should show only their orders to user" do
    get orders_url, params:{user_id: 2}, headers: {:Authorization => "Bearer #{@user.authentication_token}, email=#{@user.email}"}
    assert_response 200
    json_response = JSON.parse(response.body)
    assert_equal(json_response["orders"].length, 1)
  end

  test "should show all orders to admin" do
    get orders_url, headers: {:Authorization => "Bearer #{@admin_user.authentication_token}, email=#{@admin_user.email}"}
    assert_response 200
    json_response = JSON.parse(response.body)
    assert_equal(json_response["orders"].length, 3)
  end

  #create action
  test "should create order" do
    assert_difference ("Order.count") do
      post orders_url, params:{order: {user_id: @user.id, book_id: 2, order_date: Date.today, due_date: Date.today}},
        headers: {:Authorization => "Bearer #{@user.authentication_token}, email=#{@user.email}"}
    end
  end

  test "should not create order if user holds already two books" do
    assert_no_difference ("Order.count") do
      post orders_url, params:{order: {user_id: @admin_user.id, book_id: 2, order_date: Date.today, due_date: Date.today}},
        headers: {:Authorization => "Bearer #{@admin_user.authentication_token}, email=#{@admin_user.email}"}
    end
    json_response = JSON.parse(response.body)
    assert_equal(json_response["errors"], "Exceeded borrowing limit!")
  end

  test "should not create order if user doesn't have enough money" do
    @user.wallet = 0;
    @user.save
    assert_no_difference ("Order.count") do
      post orders_url, params:{order: {user_id: @user.id, book_id: 2, order_date: Date.today, due_date: Date.today}},
        headers: {:Authorization => "Bearer #{@user.authentication_token}, email=#{@user.email}"}
    end
    json_response = JSON.parse(response.body)
    assert_equal(json_response["errors"], "Not enough Money!")
  end

  test "should reduce amount from user wallet upon successful order creation" do
    @user.wallet = 200
    @user.save
    post orders_url, params:{order: {user_id: @user.id, book_id: 2, order_date: Date.today, due_date: Date.today}},
      headers: {:Authorization => "Bearer #{@user.authentication_token}, email=#{@user.email}"}
    assert_response 201
    @user.reload
    json_response = JSON.parse(response.body)
    assert_equal(0, @user.wallet)
  end

  test "should reduce book quantity upon successful order creation" do
      book = Book.new(isbn: 1234, title: "Testing", author: "Author", price: 100, fine: 10, quantity: 1)
      book.save
      post orders_url, params:{order: {user_id: @user.id, book_id: book.id, order_date: Date.today, due_date: Date.today}},
        headers: {:Authorization => "Bearer #{@user.authentication_token}, email=#{@user.email}"}
      assert_response 201
      book.reload
      json_response = JSON.parse(response.body)
      assert_equal(0, book.quantity)
    end

  # update action
  test "should update order with return date" do
    patch order_url(@order), params:{order:{return_date: Date.today}},
      headers: {:Authorization => "Bearer #{@user.authentication_token}, email=#{@user.email}"}
    assert_response 200
    json_response = JSON.parse(response.body)
    assert(json_response["order"]["return_date"])
  end

  test "should not return book if user doesn't have fine amount" do
    @user.wallet = 0
    @user.save
    @order.due_date = Date.yesterday
    @order.save
    patch order_url(@order), params:{order:{return_date: Date.today}},
      headers: {:Authorization => "Bearer #{@user.authentication_token}, email=#{@user.email}"}
    assert_response 400
    json_response = JSON.parse(response.body)
    assert_equal("Not enough Money!", json_response["msg"])
  end
end
