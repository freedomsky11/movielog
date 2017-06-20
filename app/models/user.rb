class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :groups
  has_many :reviews
  has_many :movie_relationships
  has_many :comment_movies, :through => :movie_relationships, :source => :movie

  def is_commentator_of?(movie)
    comment_movies.include?(movie)
  end
end
