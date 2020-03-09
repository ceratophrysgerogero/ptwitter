# frozen_string_literal: true

module MicropostDecorator
  def decorated_content
    if content_object.reply?
      link_to("@#{in_reply_to.name}", in_reply_to) + " " + content_object.content
    else
      content
    end
  end

  def test
  end
  
end
