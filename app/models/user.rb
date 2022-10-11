class User < ActiveRecord::Base
  has_many :bookings
  has_many :spaces
end