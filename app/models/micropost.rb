class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> {order(created_at: :desc)}
  mount_uploaders :pictures, PictureUploader
  serialize :pictures, JSON
  validates :user_id, presence: true
  validates :content, presence: true
  validate  :picture_size

  private

  # アップロードされた画像のサイズをバリデーションする
  def picture_size
    if pictures.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
