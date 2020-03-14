# frozen_string_literal: true

module MicropostDecorator
  def decorated_content
    if content_object.reply?
      link_to("@#{in_reply_to.name}", in_reply_to) + " " + markdown(content_object.content).html_safe
    else
      markdown(content).html_safe
    end
  end

  def test
  end
  
end
