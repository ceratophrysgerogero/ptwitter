require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @non_admin = users(:john)
    @admin = users(:bobu)
  end

  test "ユーザー一覧ページネート機能" do
    log_in_as(@non_admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    User.paginate(page: 1).each do |user|
      assert_select 'a[href=?]',user_path(user),text: user.name
    end
  end

  test "アドミンでログインしてアドミンユーザー以外のユーザーを一つ消す" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    first_page_user = User.paginate(page:1)
    first_page_user.each do |user|
      unless user == @adomin
        assert_select 'a[href=?]', user_path(user), test: 'delete'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "アドミンではないユーザーは削除するリンクが見えない" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text:'delete', count:0
  end
end
