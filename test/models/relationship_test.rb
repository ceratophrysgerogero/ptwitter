require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase

  def setup
    @relationship = Relationship.new(follower_id: users(:bobu).id,
                                     followed_id: users(:archer).id)
  end
  
  test "validできるか" do
    assert @relationship.valid?
  end

  test "follower_idが必要" do
    @relationship.follower_id = nil
    assert_not @relationship.valid?
  end

  test "followed_idが必要" do
    @relationship.followed_id = nil
    assert_not @relationship.valid?
  end
end
