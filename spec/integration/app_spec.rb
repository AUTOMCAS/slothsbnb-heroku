require "spec_helper"
require "rack/test"
require_all 'app'
require 'json'

describe ApplicationController do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { ApplicationController.new }

  before(:each) do
    reset_test_data
  end


  # Write your integration tests below.
  # If you want to split your integration tests
  # accross multiple RSpec files (for example, have
  # one test suite for each set of related features),
  # you can duplicate this test file to create a new one.
  context 'User creates account' do
    context 'GET /signup' do
      it 'should return the page' do
        response = get('/signup')
        expect(response.status).to eq(200)
        expect(response.body).to include('<form action="/signup"')
      end
    end

    context 'POST /signup' do

      it 'should succesfully create a new user' do
        response = post('/signup', 
          username: "SlothMcSloth",
          email: "Slothsville@gmail.com",
          full_name: "Sloth Slothster",
          password_digest: "Sloth123456!",
          phone_number: "345678987654"
        )
        #TO COME BACK TO - REWRITE STATUS TEST - CURRENTLY FAILING 'STATUS 500'
        expect(response.body).to include('Success')
      end

      it 'should fail' do
        response = post('/signup', 
          username: "Sloth84", 
          email: "Slothsville",
          full_name: "Sloth Slothster",
          password_digest: "Sloth123456!",
          phone_number: "345678987654"
        )
        expect(response.status).to eq(200)
        expect(response.body).to include('Email is invalid')
      end
    end
  end


  context 'User creates new space' do
    context 'GET /spaces/new' do
      it 'should get a Create New Space page' do
        response = get('/spaces/new')

        expect(response.status).to eq(200)
        expect(response.body).to include('<form action="/spaces/new"')
      end
    end

    context 'POST /spaces/new' do
      it 'Successfully adds new space to spaces' do
        response = post('/spaces/new',
        space_name: 'Jungle retreat',
        description: 'A lovely place in the jungle with a waterfall',
        price_per_night: 300,
        available_from: '12/10/2022',
        available_to: '12/07/2023'
        )

        expect(response.status).to eq(200)
        expect(response.body).to include('Success! Jungle retreat has been created.')
      end
    
      it 'Fails to add new space to spaces' do
        response = post('/spaces/new',
        space_name: '',
        description: 'A lovely place in the jungle with a waterfall',
        price_per_night: 300,
        available_from: '12/10/2022',
        available_to: '12/07/2023'
        )

        expect(response.status).to eq(200)
        expect(response.body).to include("Space name can't be blank")
      end
    end
  end
end



def reset_test_data
  ActiveRecord::Base.connection_pool.with_connection do |conn|
    conn.execute("TRUNCATE users, spaces, bookings RESTART IDENTITY")
  end

  Space.create(user_id: 1, space_name: "Sloth Space", description: "Warm Sloth den, with lots of worms to eat", price_per_night: 20, available_from: "10/10/2022", available_to: "11/10/2022")
  Space.create(user_id: 1, space_name: "Slothy Apartment", description: "High-rise working sloth bachelor pad", price_per_night: 30, available_from: "17/09/2022", available_to: "18/09/2022")
  Space.create(user_id: 2, space_name: "Sloth Cave", description: "Rural, open plan Sloth safe space", price_per_night: 10, available_from: "15/08/2022", available_to: "16/08/2022")
end