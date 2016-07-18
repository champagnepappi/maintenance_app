class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :request
  default_scope -> {order(created_at: :desc)}
  validates :user_id, presence: true
  validates :request_id, presence: true
  validates :content, presence: true, length: {maximum: 150}
end
