class Service < ActiveRecord::Base
  belongs_to :experience
  belongs_to :provider
end
