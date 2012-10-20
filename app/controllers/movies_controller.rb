class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    
    @all_ratings = Movie.ratings
    
    if params.has_key? 'order_by'
      @ordered_by = params[:order_by]
      session[:ordered_by] = @ordered_by
    else
      @ordered_by = session[:ordered_by]
    end
    
    if params.has_key? 'ratings'
      @checked_ratings = params[:ratings] 
      session[:checked_ratings] = @checked_ratings
    elsif session.has_key? 'checked_ratings'
      @checked_ratings = session[:checked_ratings]
    else
      @checked_ratings = Movie.ratings
    end
    
    #flash[:notice] = "#{@ordered_by} . #{@checked_ratings}"
    #@ordered_by = session[:ordered_by] if @ordered_by
    #@checked_ratings = session[:checked_ratings] if @checked_ratings
    #@checked_ratings = Movie.ratings if @checked_ratings
    
    # update session from incoming params
    #session[:ordered_by] = @ordered_by if @ordered_by
    #session[:checked_ratings] = @checked_ratings if @checked_ratings
    
    #if @ordered_by || @checked_ratings #&& session[:checked_ratings]
    #  flash.keep
    #  redirect_to movies_path({order_by: @ordered_by, ratings: @checked_ratings})
    #end
    
    if @checked_ratings != Movie.ratings
      if @ordered_by
        @movies = Movie.find_all_by_rating(@checked_ratings, :order => "#{@ordered_by} asc")
      else
        @movies = Movie.find_all_by_rating(@checked_ratings)
      end
    elsif @ordered_by
      @movies = Movie.all(:order => "#{@ordered_by} asc")
    else
      @movies = Movie.all
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
