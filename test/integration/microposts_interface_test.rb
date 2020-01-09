require 'test_helper'

class MicropostInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:bobu)
  end


  test "マイページのマイクロポストの投稿数"do
    log_in_as(@user)
    get root_path
    assert_match "#{@user.microposts.count} マイクロポスト", response.body
    # まだマイクロポストを投稿していないユーザー
    other_user = users(:malory)
    log_in_as(other_user)
    get root_path
    assert_match "0 マイクロポスト", response.body
    other_user.microposts.create!(content: "A micropost")
    get root_path
    assert_match "1 マイクロポスト", response.body 
  end
end
