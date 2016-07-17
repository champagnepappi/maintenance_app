class Request < ApplicationRecord
  belongs_to :user
  #set order in which elements are retrieved from db
  default_scope -> {order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 200}
end
