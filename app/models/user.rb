class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token
  enum role: {user: 0, admin: 1, maintainer: 2}
  has_many :requests, dependent: :destroy
  has_many :comments
  before_save :downcase_email
  before_create :create_activation_digest
  name_regex = /\A[a-z]+\Z/i
  validates :name, presence: true, length: {minimum: 3,maximum: 40}, format: {with: name_regex}
    # format:{with: /\A[-a-z]+\Z/, message: " cannot contain numbers"}
  validates :contact, presence: true, length: {maximum: 10},numericality: {only_integer: true}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email,presence: true, length: {maximum: 100},
             format: {with: VALID_EMAIL_REGEX},
             uniqueness: {case_sensitive: false}

  has_secure_password
  validates :password, length: { minimum: 5 }, allow_blank: true

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
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  #verify that remember digest matches remember token
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  #activate account
  def activate
    update_attribute(:activated,  true)
    update_attribute(:activated_at, Time.zone.now)
  end

  #send activation email
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end
  def send_approval_email
    UserMailer.accept(self).deliver_now
  end


  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  #sends password reset email
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def send_comment_email
    UserMailer.new_comment(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  #forget user
  def forget
    update_attribute(:remember_digest, nil)
  end

  #define feed
  def feed
    Request.where("user_id = ?", id) #escape id to avoid SQL injection
  end

  private
  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
