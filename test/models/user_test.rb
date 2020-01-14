require 'test_helper'

class UserTest < ActiveSupport::TestCase
 
 def setup
   @user = users(:bobu)
 end

 test "vaildできるか" do
   @user.password = "password"
   @user_password_confirmation ="password"
   assert @user.valid?
 end

 test "名前が入っていない場合弾けるか" do
   @user.name =""
   assert_not @user.valid?
 end

 test "名前が空白の場合弾けるか" do
   @user.name = "  "
   assert_not @user.valid?
 end

 test "メールが入っていない場合弾けるか" do
   @user.email =""
   assert_not @user.valid?
 end

 test "メールが空白の場合弾けるか" do
   @user.email = "  "
   assert_not @user.valid?
 end

 test "名前制限51文字" do
   @user.name = "a"*51
   assert_not @user.valid?
 end

 test "メールアドレス244文字制限" do
   @user.email = "a"*244+"@example.com"
   assert_not @user.valid?
 end

 test "メールアドレスバリデーション" do
   invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
   invalid_addresses.each do |invalid_address|
     @user.email = invalid_address
     assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
   end
 end

 test "重複したメールを登録しない" do
   duplicate_user = @user.dup
   duplicate_user.email = @user.email.upcase
   @user.save
   assert_not duplicate_user.valid?
 end

 test "登録したメールアドレスが全て小文字になっているか" do
   mixed_case_email = "BoBU@Example.Com"
   @user.email = mixed_case_email
   @user.save
   assert_equal mixed_case_email.downcase, @user.reload.email
 end

   test "パスワードが空文字六文字"do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "パスワードが五文字" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "ユーザーのauthenticated?が空の場合" do
    assert_not @user.authenticated?('')
  end

  test "1つのユーザーが消える連携されているマイクロポストも消える" do
    @user.save 
    @user.microposts.create!(content: "テストコンテント")
    user_microposts_num = @user.microposts.count
    assert_difference 'Micropost.count',-user_microposts_num do
      @user.destroy
    end
  end

  test "フォローとフォロー解除" do
    bobu = users(:bobu)
    archer  = users(:archer)
    assert_not bobu.following?(archer)
    bobu.follow(archer)
    assert bobu.following?(archer)
    bobu.unfollow(archer)
    assert_not bobu.following?(archer)
  end
end
