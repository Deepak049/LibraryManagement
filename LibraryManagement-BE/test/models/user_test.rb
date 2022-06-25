require "test_helper"

class UserTest < ActiveSupport::TestCase
    test "should not save user without first name and last name" do
        user = User.new(email: "test@gmail.com", password: "password")
        assert_not(user.save, "Saved without first name and last name")
    end

    test "should not save user without email" do
        user = User.new(first_name: "Test", last_name: "User", password: "password")
        assert_not(user.save, "Saved without email")
    end

    test "should save user with first_name, last_name, email and password" do
        user = User.new(first_name: "Test", last_name: "User", email: "test@gmail.com", password: "password")
        assert(user.save, "User is not saved with proper details")
    end

    test "email of the users should be unique" do
        first_user = User.new(first_name: "First", last_name: "User", email: "test@gmail.com", password: "password")
        assert(first_user.save)
        second_user = User.new(first_name: "Second", last_name: "User", email: "test@gmail.com", password: "password")
        assert_not(second_user.save, "Saved two users with same email")
    end

    test "should generate token in every user creation" do
        user = User.new(first_name: "Test", last_name: "User", email: "test@gmail.com", password: "password")
        user.save
        assert(user.authentication_token)
    end

    test "should encrypt password" do
        user = User.new(first_name: "Test", last_name: "User", email: "test@gmail.com", password: "password")
        user.save
        assert_not_equal(user.password_digest, "password", "password is saved without ecryption")
    end


    test "should not make user an admin on creation" do
        user = User.new(first_name: "Test", last_name: "User", email: "test@gmail.com", password: "password")
        user.save
        assert_not(user.is_admin, "user is created as admin")
    end

    test "should create user in active state" do
        user = User.new(first_name: "Test", last_name: "User", email: "test@gmail.com", password: "password")
        user.save
        assert(user.is_active, "user is not created as active")
    end

    test "should create user with some default wallet amount" do
        user = User.new(first_name: "Test", last_name: "User", email: "test@gmail.com", password: "password")
        user.save
        assert_equal(user.wallet, 10000, "user is created without wallet amount")
    end

    test "should confirm password and password be same" do
        user = User.new(first_name: "Test", last_name: "User", email: "test@gmail.com", password: "password", password_confirmation: "pass")
        assert_not(user.save, "user is created with wrong confirm password")
    end
end