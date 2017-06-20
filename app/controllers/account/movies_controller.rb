class Account::MoviesController < ApplicationController
  before_action :authenticate_user!

  def index
    @movies = current_user.collect_movies.recent.paginate(:page => params[:page], :per_page => 5)
  end
end
