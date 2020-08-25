class ReviewsController < ApplicationController

  def new
    # require "pry"; binding.pry
    @shelter = Shelter.find(params[:shelter_id])
    @shelter_id = params[:shelter_id]
  end

  def create
     @shelter = Shelter.find(params[:shelter_id])
     review = @shelter.reviews.new(review_params)
     if review.save
       redirect_to("/shelters/#{@shelter.id}/reviews")
     else
       flash[:notice] = "Review not created: Required information missing"
       render :new
     end
   end

   def show
     @shelter = Shelter.find(params[:shelter_id])
   end

   private
   def review_params
     params.permit(:title, :rating, :content, :optional_picture)
   end
end
