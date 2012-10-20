module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  
  def was_sorted?(column)
   @ordered_by==column ? 'hilite' : ''
  end

  def is_selected?(rating)
   @checked_ratings.include? rating unless !@checked_ratings
  end

  def create_order_params(column)
   {order_by: column, ratings: @checked_ratings}
  end  
end
