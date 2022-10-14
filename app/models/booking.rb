class Booking < ActiveRecord::Base
  belongs_to :user 
  belongs_to :space 

  validates :booking_date,
  presence: true
end