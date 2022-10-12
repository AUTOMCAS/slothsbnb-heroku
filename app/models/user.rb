class User < ActiveRecord::Base
  has_many :bookings
  has_many :spaces
  has_secure_password

  validates :username,
  presence: true,
  uniqueness: true

  validates :email,
  presence: true,
  uniqueness: true,
  format:{with: URI::MailTo::EMAIL_REGEXP}

  validates :full_name,
  presence: true

  validates :password,
  presence: true,
  length: { minimum: 8 }

  validates :phone_number,
  presence: true,
  length: { in: 7..20 }
  
end


