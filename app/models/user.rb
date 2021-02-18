class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  devise :database_authenticatable, :registerable

  has_many :posts
  has_many :comments

  has_one_attached :avatar

  before_save { |user| user.email = email.downcase }

  validates :name, presence: true, length: { in: 1..50 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
end
