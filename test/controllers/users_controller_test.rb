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

  test "webでアドミン権限を変更することを許可しない" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user),params: {
      user: { password: @other_user.password,
              password_confiramation: @other_user.password,
              admin: true}
    }
    assert_not @other_user.reload.admin?
  end

  test "ログインしてない場合ユーザーを削除できなくリダイレクトする" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test "アドミンユーザーでなければユーザー削除はできずリダイレクトする" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end

  test "フォローパスにログインなしでアクセスした場合はリダイレクトする" do
    get following_user_path(@user)
    assert_redirected_to login_url
  end

  test "フォロワーパスにログインなしでアクセスした場合はリダイレクトする" do
    get followers_user_path(@user)
    assert_redirected_to login_url
  end
end
