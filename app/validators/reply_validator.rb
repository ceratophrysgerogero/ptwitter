class ReplyValidator < ActiveModel::Validator
  def validate(record)
    if record.in_reply_to.nil?  
      record.errors.add('content', "User ID does not exist or account is anactivated.")
    elsif record.in_reply_to.reply_name.attr_reader !=
          record.content_object.reply_name.attr_reader
      record.errors.add('content', "Reply Name is invalid.")
    elsif record.in_reply_to == record.user 
      record.errors.add('content', "can not reply to myself.")
    end
  end
end
