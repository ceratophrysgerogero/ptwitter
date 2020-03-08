class ReplyName
  attr_reader :user_id
  attr_reader :user_name

  def initialize(user_id, user_name)
    @user_id = user_id
    @user_name = user_name
  end

  def valid?
    !!@user_id && !!@user_name
  end
  

  def attr_reader
    [@user_id,@user_name]
  end
end

