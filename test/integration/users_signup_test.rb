require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "無効なユーザー登録" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: {user: { name: "",
                                        email: "user@test",
                                        password: "pass",
                                        password_confirmation: "bar" }}
    end
    assert_template 'users/new'
  end
end
