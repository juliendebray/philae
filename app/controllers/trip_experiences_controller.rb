class TripExperiencesController < ApplicationController


  def create
    @trip_experience = TripExperience.new(trip_experience_params)
    @trip_experience.save
  end

  def destroy
  end

   private
   def trip_experience_params
      params.require(:trip_experience).permit(:experience_id, :trip_id)
    end

end
