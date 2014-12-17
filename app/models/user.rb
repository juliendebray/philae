class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [ :facebook ]

  validates :email, presence: true
  # validates :first_name, presence: true

  has_many :trips
  has_many :friends

  has_many :relationships

  after_create :send_welcome_email


  def self.find_for_facebook_oauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.name = auth.info.name
      # user.first_name = auth.info.first_name
      # user.last_name = auth.info.last_name
      user.picture = auth.info.image
      user.token = auth.credentials.token
      user.token_expiry = Time.at(auth.credentials.expires_at)
    end
  end

  def send_trip_email(trip)
    UserMailer.share_trip(self, trip).deliver
  end

  private
  def send_welcome_email
    UserMailer.welcome(self).deliver
  end

end
