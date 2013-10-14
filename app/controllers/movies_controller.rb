class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.ratings
    if !session[:ratings]
      session[:ratings] = Movie.ratings_hash
    end

    if !params[:ratings]
      if params[:sort] == "title"
        session[:sort] = "title"
        @movies = Movie.find_all_by_rating(session[:ratings].keys, :order => "title")
      elsif params[:sort] == "release_date"
        session[:sort] = "release_date"
        @movies = Movie.find_all_by_rating(session[:ratings].keys, :order => "release_date")
      else
        @movies = Movie.find_all_by_rating(session[:ratings].keys)
      end

    else
      session[:ratings] = params[:ratings]
      if params[:sort] == "title"
        session[:sort] = "title"
        @movies = Movie.find_all_by_rating(params[:ratings].keys, :order => "title")
      elsif params[:sort] == "release_date"
        session[:sort] = "release_date"
        @movies = Movie.find_all_by_rating(params[:ratings].keys, :order => "release_date")
      else
        @movies = Movie.find_all_by_rating(params[:ratings].keys)
      end
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
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
