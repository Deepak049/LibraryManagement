require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book = books(:one)
    @admin_user = users(:user)
    @user = users(:not_admin)
  end

  # show action
  test "should return book on show url" do
    get book_url(@book), headers: {:Authorization => "Bearer #{@user.authentication_token}, email=#{@user.email}"}
    assert_response 200
    json_response = JSON.parse(response.body)
    assert_equal(json_response["book"]["id"], @book.id)
  end

  # index action
  test "should return all books if admin" do
    get books_url, headers: {:Authorization => "Bearer #{@admin_user.authentication_token}, email=#{@admin_user.email}"}
    assert_response 200
    json_response = JSON.parse(response.body)
    assert_equal(json_response["books"].length, 3)
  end

  test "should return remaining unborrowed books on passing user id" do
    get books_url, params:{user_id: @user.id}, headers: {:Authorization => "Bearer #{@user.authentication_token}, email=#{@user.email}"}
    assert_response 200
    json_response = JSON.parse(response.body)
    assert_equal(json_response["books"].length, 2)
  end

  # create action
  test "should user not be able to create book" do
    assert_no_difference ("Book.count") do
      post books_url, params:{book: {isbn: 123, title: "test", author: "tester"}},
        headers: {:Authorization => "Bearer #{@user.authentication_token}, email=#{@user.email}"}
    end
  end

  test "should admin only create book" do
    assert_difference ("Book.count") do
      post books_url, params:{book: {isbn: 123, title: "test", author: "tester"}},
        headers: {:Authorization => "Bearer #{@admin_user.authentication_token}, email=#{@admin_user.email}"}
    end
  end

  #update action
  test "should user not be able to update book" do
    patch book_url(@book), params:{book: {isbn: 123, title: "Updated", author: "tester"}},
      headers: {:Authorization => "Bearer #{@user.authentication_token}, email=#{@user.email}"}
    assert_response 400
    json_response = JSON.parse(response.body)
    assert_equal(json_response["errors"], "Unauthorized")
  end

  test "should admin only update book" do
    patch book_url(@book), params:{book: {isbn: 123, title: "Updated", author: "tester"}},
      headers: {:Authorization => "Bearer #{@admin_user.authentication_token}, email=#{@admin_user.email}"}
    assert_response 200
    json_response = JSON.parse(response.body)
    assert_equal(json_response["book"]["title"], "Updated")
  end

  #destroy action
  test "should user not be able to disable book" do
    delete book_url(@book), headers: {:Authorization => "Bearer #{@user.authentication_token}, email=#{@user.email}"}
    assert_response 400
    json_response = JSON.parse(response.body)
    assert_equal(json_response["errors"], "Access Denied")
  end

  test "should admin disable book" do
    delete book_url(@book), headers: {:Authorization => "Bearer #{@admin_user.authentication_token}, email=#{@admin_user.email}"}
    assert_response 200
    json_response = JSON.parse(response.body)
    assert_equal(json_response["book"]["is_active"], false)
  end

end
