require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:bobu)
    @other_user = users(:john)
  end
  
  test "ログインなしでユーザーを作成する" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "ログインなしでユーザーを編集する" do
    patch user_path(@user), params: { user: { name: @user.name, email: @user.email }}
    assert_not flash.empty?
    assert_redirected_to login_url
  end


  test "ログインしているユーザーではないユーザーが編集する" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "ユーザー編集ページはログインしていないと見れない" do
    get users_path
    assert_redirected_to login_url
  end
end
