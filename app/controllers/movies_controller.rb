class MoviesController < ApplicationController

  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy, :collect, :cancel]
  before_action :find_movie_and_check_permission, only: [:edit, :update, :destroy]

  def index
    @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def show
    @movie = Movie.find(params[:id])
    @reviews = @movie.reviews.recent.paginate(:page => params[:page], :per_page => 5)
  end

  def edit
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.user = current_user

    if @movie.save
      redirect_to movies_path
    else
      render :new
    end
  end

  def update
    if @movie.update(movie_params)
      redirect_to movies_path, notice: "Update success."
    else
      render :edit
    end
  end

  def destroy
    @movie.destroy
    flash[alert] = "Movie deleted."
    redirect_to movies_path
  end

  def collect
    @movie = Movie.find(params[:id])

    if !current_user.is_collector_of?(@movie)
      current_user.collect!(@movie)
      flash[:notice] = "收藏该电影成功！"
    else
      flash[:warning] = "你已经收藏该电影了！"
    end

    redirect_to movie_path(@movie)
  end

  def cancel
    @movie = Movie.find(params[:id])

    if current_user.is_collector_of?(@movie)
      current_user.cancel!(@movie)
      flash[:alert] = "已取消收藏该电影！"
    else
      flash[:warning] = "你没有收藏该电影！"
    end

    redirect_to movie_path(@movie)
  end

  private


  def find_movie_and_check_permission
    @movie = Movie.find(params[:id])

    if current_user != @movie.user
      redirect_to root_path, alert: "You have no permission."
    end
  end

  def movie_params
    params.require(:movie).permit(:title, :description)
  end

end
