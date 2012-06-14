class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @checked_ratings_param = params[:ratings]
    if params[:ratings] == nil
      @checked_ratings = nil
    else
      @checked_ratings = params[:ratings].keys
    end
    @movies = Movie.find(:all, :order => params[:sort_by].to_s, :conditions => ["rating IN (?)", @checked_ratings])
    @sort_by = params[:sort_by]
    @all_ratings = Movie.all_ratings
  end

  def new
    # default: render 'new' template
    @all_ratings = Movie.all_ratings
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
    @all_ratings = Movie.all_ratings
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
