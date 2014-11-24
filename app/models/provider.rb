class Provider < ActiveRecord::Base
  has_many :services
  has_many :experiences, through: :services
end
