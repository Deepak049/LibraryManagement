require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
    test "should send token and email as a response for successful login" do
        user = User.new(first_name: "Test", last_name: "User", email: "test@gmail.com", password: "password")
        user.save
        post "/signin", params: {user: {email: "test@gmail.com", password: "password"}}, as: :json
        json_response = JSON.parse(response.body)
        assert_response 201
        assert_equal(json_response['token'], user.authentication_token, "Authentication token is not same")
        assert_equal(json_response['email'], user.email, "Email is not same")
    end

    test "should show error message for invalid login" do
        user = User.new(first_name: "Test", last_name: "User", email: "test@gmail.com", password: "password")
        user.save
        post "/signin", params: {user: {email: "test@gmail.com", password: "pass"}}, as: :json
        json_response = JSON.parse(response.body)
        assert_response 403
        assert_nil(json_response['token'])
        assert_nil(json_response['email'])
        assert_equal(json_response['errors'], "Please check your email/password!")
    end

    test "should show error message for inactive user login" do
        user = User.new(first_name: "Test", last_name: "User", email: "test@gmail.com", password: "password")
        user.is_active = false
        user.save
        post "/signin", params: {user: {email: "test@gmail.com", password: "password"}}, as: :json
        json_response = JSON.parse(response.body)
        assert_response 403
        assert_nil(json_response['token'])
        assert_nil(json_response['email'])
        assert_equal(json_response['errors'], "Your account is disabled, contact Admin!")
    end
end