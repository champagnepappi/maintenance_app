class Request < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  enum status: {requested: 0, approved: 1, rejected: 2, assigned: 3}
  #set order in which elements are retrieved from db
  default_scope -> {order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 200}
  validate :picture_size

  # def send_approval_email
  #   UserMailer.accept(self).deliver_now
  # end

  private
  #validate size of an uploaded image
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "File too large(should be less than 5MB)")
    end
  end
end
