class Movie < ApplicationRecord
  validates :title, presence: true
  belongs_to :user
  has_many :reviews
  has_many :movie_relationships
  has_many :collectors, through: :movie_relationships, source: :user

  scope :recent, -> { order("created_at DESC")}

end
