class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :groups
  has_many :reviews
  has_many :movie_relationships
  has_many :collect_movies, :through => :movie_relationships, :source => :movie

  def is_collector_of?(movie)
    collect_movies.include?(movie)
  end
end
