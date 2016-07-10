class User < ApplicationRecord
  validates :name, presence: true, length: {maximum: 40}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email,presence: true, length: {maximum: 100},
             format: {with: VALID_EMAIL_REGEX},
             uniqueness: {case_senesitive: false}

  has_secure_password
  validates :password, length: { minimum: 5 }
end