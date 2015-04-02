class ExperienceReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_experience, only: [:new, :create]

  def new
    @experience_review = @experience.experience_reviews.new
  end

  def create
    experience_review = @experience.experience_reviews.new(experience_params)
     experience_review.user = current_user
     experience_review.save
    if experience_review.save
      flash[:notice] = "Review has been saved"
      # redirect_to experience_path(@experience)
      redirect_to :back
    else
      render :new
    end
  end

  # def create_from_modal
  #   experience_review = @experience.experience_reviews.new(experience_params)
  #    experience_review.user = current_user
  #    experience_review.save
  #   if experience_review.save
  #     flash[:notice] = "Review has been saved"
  #     render :new
  #   end
  # end

  private
  def find_experience
    @experience = Experience.find(params[:experience_id])
  end

  def experience_params
    params.require(:experience_review).permit(:comment, :rating, :name, :created_at, :original_date)
  end
end
