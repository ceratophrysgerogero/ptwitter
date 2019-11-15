require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "有効なユーザー登録" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: {user: { name: "test",
                                        email: "test@test.com",
                                        password: "password",
                                        password_confirmation: "password" }}
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.nil?
    assert is_logged_in?
  end
   

  test "無効なユーザー登録" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: {user: { name: "",
                                        email: "user@test",
                                        password: "pass",
                                        password_confirmation: "pass" }}
    end
    assert_template 'users/new'
  end
end
