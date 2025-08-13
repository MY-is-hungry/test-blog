class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 200 }
  validates :body, presence: true

  scope :recent, -> { order(created_at: :desc) }
end

