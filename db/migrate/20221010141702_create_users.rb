class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t| # specifying name of the table
      t.string :username
      t.string :full_name
      t.string :password_digest # Passwords will be converted and stored in a hash
      t.string :email
      t.string :phone_number
    end
  end
end
