require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:bobu)
  end

  test "編集失敗" do
    get edit_user_path(@user)
    assert_template "users/edit"
    patch user_path(@user), params: { user: { name: "",
                                              email: "foo@bar",
                                              password: "pass",
                                              password_confirmation: "bar" }}
    assert_template "users/edit"
  end

end
