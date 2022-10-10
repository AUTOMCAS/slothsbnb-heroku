class CreateSpaces < ActiveRecord::Migration[7.0]
  def change
    create_table :spaces do |t| # specifying name of the table
      t.integer :user_id
      t.string :space_name
      t.text :description
      t.decimal :price_per_night
      t.date :available_from
      t.date :available_to
    end
  end
end
