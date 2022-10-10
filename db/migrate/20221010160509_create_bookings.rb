class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t| # specifying name of the table
      t.integer :user_id
      t.integer :space_id
      t.date :booking_date
      t.boolean :pending_confirmation
      t.boolean :confirmed
    end
  end
end
