# frozen_string_literal: true

require 'test_helper'

class MicropostDecoratorDecoratorTest < ActiveSupport::TestCase
  def setup
    @micropost_decorator = MicropostDecorator.new.extend MicropostDecoratorDecorator
  end

  # test "the truth" do
  #   assert true
  # end
end
