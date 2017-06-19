class Review < ApplicationRecord
  validates :content, presence: true

  belongs_to :user
  belongs_to :movie

  scope :recent, -> { order("created_at DESC")}
end
