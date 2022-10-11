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

# s=Space.new(space_name: 'Makers', description: 'onetwoonetwothew owoeaw onetwoonetwothew owoeaw', price_per_night: 150.54, available_from: '12/12/1912', available_to: '01/01/2021')
