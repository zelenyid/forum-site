class Post < ApplicationRecord
  has_many :comments

  belongs_to :user
  belongs_to :topic

  validates :title, presence: true, length: { in: 5..50 }
  validates :body, presence: true, length: { minimum: 10 }
end
