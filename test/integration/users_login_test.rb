require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup 
    @user = users(:bobu)
  end

  test "ログイン失敗時のflash" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "有効なログイン" do
    get login_path
    post login_path, params: { session: { email: @user.email, password: 'password'} }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'   
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end

  test "正常なログインからログアウトまで" do
    get login_path
    post login_path, params: { session: { email: @user.email, password: 'password' }}
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path, count: 1
    assert_select "a[href=?]", user_path(@user),  count: 1
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_path
    #二番目のウィンドウでログアウトをクリックすることをシミュレートする↓
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path, count: 1 
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user),  count: 0
  end

  test "クッキーを使った永続的ログイン" do
    log_in_as(@user)
    assert_not_empty cookies['remember_token']
  end

  test "クッキーを使った永続ログインした後通常ログイン" do
    log_in_as(@user)
    delete logout_path
    log_in_as(@user, remember_me: '0')
    assert_empty cookies['remember_token']
  end
end



