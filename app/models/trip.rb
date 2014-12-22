class Trip < ActiveRecord::Base
  belongs_to :user

  has_many :trip_experiences
  has_many :experiences, through: :trip_experiences

  has_many :trip_comments

  after_save :generate_token, if: :user_id_changed?

  def generate_url_with_token
  puts 'triiiiip'
  "/trips/#{self.id}/#{self.token}"
  puts "/trips/#{self.id}/#{self.token}"
  end


  private
  def generate_token
    unless self.token
      random_token = SecureRandom.urlsafe_base64(nil, false)
      while Trip.where(token: random_token).any?
        random_token = SecureRandom.urlsafe_base64(nil, false)
      end
      self.token = random_token
      self.save
    end
  end
end
