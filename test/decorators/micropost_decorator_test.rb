# frozen_string_literal: true

require 'test_helper'

class MicropostDecoratorTest < ActiveSupport::TestCase
  def setup
    @micropost = Micropost.new.extend MicropostDecorator
  end

  # test "the truth" do
  #   assert true
  # end
end
