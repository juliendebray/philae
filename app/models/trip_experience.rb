class TripExperience < ActiveRecord::Base
  belongs_to :trip
  belongs_to :experience

  after_validation :set_order, if: :set_order_needed?

  private
  def set_order_needed?
    self.order.nil?
  end

  def set_order
    self.order = self.trip.trip_experiences.count + 1
  end
end