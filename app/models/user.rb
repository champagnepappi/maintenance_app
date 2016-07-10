class User < ApplicationRecord
  validates :name, presence: true, length: {maximum: 40}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email,presence: true, length: {maximum: 100},
             format: {with: VALID_EMAIL_REGEX},
             uniqueness: {case_senesitive: false}

  has_secure_password
  validates :password, length: { minimum: 5 }

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  #generate random token
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  #remember user
  def remember
    self.remember_token = User.new_token
    update_attributes(:remember_digest, User.digest(remember_token))
  end

  #verify that remember digest matches remember token
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  #forget user
  def forget
    update_attribute(:remember_digest, nil)
  end
end
