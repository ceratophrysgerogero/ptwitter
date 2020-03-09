class Micropost < ApplicationRecord
  before_validation :assign_in_reply_to
  composed_of :content_object, class_name: "MicropostContent",
    mapping: %w(content micropost_content)
  belongs_to :in_reply_to, class_name: "User", foreign_key: "in_reply_to_id", optional: true
  belongs_to :user
  default_scope -> {order(created_at: :desc)}
  mount_uploaders :pictures, PictureUploader
  serialize :pictures, JSON
  validates :user_id, presence: true
  validates :content, presence: true
  validate :picture_size
  validates :content_object, presence: true
  validates_with ReplyValidator, if: -> { content_object.reply? }

  # リプライを含めたスコープ
  def self.including_replies(user_id)
    where("user_id = :user_id OR in_reply_to_id = :user_id", user_id: user_id)
  end

  def assign_in_reply_to
    self.in_reply_to = User.find_by(id: content_object.reply_name.user_id)
    if content_object.reply?
      self.in_reply_to = User.find_by(id: content_object.reply_name.user_id)
    end
  end

  private

  # アップロードされた画像のサイズをバリデーションする
  def picture_size
    if pictures.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end

end
