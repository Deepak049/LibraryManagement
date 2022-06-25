require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = users(:user)
    @user = users(:not_admin)
  end

  # authentication token tests
  test "should not allow users to index route without token" do
    get users_url, params:{email: "testing@gmail.com"}, as: :json
    json_response = JSON.parse(response.body)
    assert_response 401
    assert_equal(json_response['msg'], "Unauthorized")
  end

  test "should not allow if token isinvalid" do
    get users_url, headers: {:Authorization => "Bearer"}
    json_response = JSON.parse(response.body)
    assert_response 401
    assert_equal(json_response['msg'], "Unauthorized")
  end

  test "should not allow if token and email doesn't match" do
    get users_url, headers: {:Authorization => "Bearer #{@admin_user.authentication_token}, email='test@gmail.com'"}
    json_response = JSON.parse(response.body)
    assert_response 401
    assert_equal(json_response['msg'], "Unauthorized")
  end

  test "should allow to access index if token and email match" do
    get users_url, headers: {:Authorization => "Bearer #{@admin_user.authentication_token}, email=#{@admin_user.email}"}
    assert_response 200
  end

  # actual users controller tests
  # index action
  test "should get user's object if email is passed" do
    get users_url, params:{email: "testing@gmail.com"} ,headers: {:Authorization => "Bearer #{@admin_user.authentication_token}, email=#{@admin_user.email}"}
    json_response = JSON.parse(response.body)
    assert_response 200
    assert_equal(json_response["user"]["id"], @admin_user.id)
  end

  test "should index return all users if request is from admin" do
    get users_url, headers: {:Authorization => "Bearer #{@admin_user.authentication_token}, email=#{@admin_user.email}"}
    assert_response 200
    json_response = JSON.parse(response.body)
    assert_equal(json_response["users"].length, 2)
  end

  # show action
  test "should not allow normal user to show url" do
    get user_url(@user), headers: {:Authorization => "Bearer #{@user.authentication_token}, email=#{@user.email}"}
    assert_response 400
    json_response = JSON.parse(response.body)
    assert_equal(json_response["errors"], "Access Denied")
  end

  test "should return user from show url if user is only admin" do
    get user_url(@user), headers: {:Authorization => "Bearer #{@admin_user.authentication_token}, email=#{@admin_user.email}"}
    assert_response 200
    json_response = JSON.parse(response.body)
    assert_equal(json_response["user"]["id"], @user.id)
  end

  # create action
  test "should create user" do
    assert_difference ("User.count")do
      post users_url, params: {user: {first_name: "Test", last_name: "User", email: "test1@gmail.com", password: "password"}}
    end
  end

  test "should not create user without email and password" do
    post users_url, params: {user: {first_name: "Test", last_name: "User"}}
    assert_response 400
    json_response = JSON.parse(response.body)
    assert_equal(json_response["errors"], ["Email can't be blank", "Password can't be blank"])
  end

  # update action
  test "should make admin to update user wallet" do
    patch user_url(@user), params: {user: {wallet: "500"}},
        headers: {:Authorization => "Bearer #{@admin_user.authentication_token}, email=#{@admin_user.email}"}
    assert_response 200
    json_response = JSON.parse(response.body)
    assert_equal(json_response["user"]["wallet"], 500)
  end

  test "should not user update his/her wallet" do
    patch user_url(@user), params: {user: {wallet: "500"}},
        headers: {:Authorization => "Bearer #{@user.authentication_token}, email=#{@user.email}"}
    assert_response 200
    json_response = JSON.parse(response.body)
    assert_not_equal(json_response["user"]["wallet"], 500)
  end

  test "should allow user to update update password only old password is correct" do
    user = User.new(first_name: "Test", last_name: "User", email: "test@gmail.com", password: "password")
    user.save
    patch user_url(user), params: {user: {old_password: "hello", password: "new_password"}},
        headers: {:Authorization => "Bearer #{user.authentication_token}, email=#{user.email}"}
    assert_response 400
    json_response = JSON.parse(response.body)
    assert_equal(json_response["errors"], "Old Password is not correct!")
  end

  # destroy action
  test "should not allow normal user to delete url" do
    delete user_url(@user), headers: {:Authorization => "Bearer #{@user.authentication_token}, email=#{@user.email}"}
    assert_response 400
    json_response = JSON.parse(response.body)
    assert_equal(json_response["errors"], "Access Denied")
  end

  test "should disable user in delete request" do
    delete user_url(@user), headers: {:Authorization => "Bearer #{@admin_user.authentication_token}, email=#{@admin_user.email}"}
    assert_response 200
    json_response = JSON.parse(response.body)
    assert_equal(json_response["user"]["is_active"], false)
  end
end