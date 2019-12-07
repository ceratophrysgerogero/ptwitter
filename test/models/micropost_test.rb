require 'test_helper'

class MicropostTest < ActiveSupport::TestCase

  def setup
    @user = users(:bobu)
    @micropost = @user.microposts.build(content: "テスト")
  end

  test "バリーデーション" do
    assert @micropost.valid?
  end

  test "user_idが存在しなければいけない" do
    @micropost.user_id =nil
    assert_not @micropost.valid?
  end



end
