class Space < ActiveRecord::Base
  belongs_to :user 
  has_many :bookings

  validates :space_name,
  presence: true,
  length: { in: 6..30 }
  

  validates :description,
  presence: true,
  length: { in: 30..600 }


  validates :price_per_night,
  presence: true,
  numericality: true
  

  validates :available_from,
  presence: true

  validates :available_to,
  presence: true
end


