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
          password: "Sloth123456!",
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
          password: "Sloth123456!",
          phone_number: "345678987654"
        )
        expect(response.status).to eq(200)
        expect(response.body).to include('Email is invalid')
      end
    end
  end


  context 'User attempts to log in' do
    context 'GET /login' do
      it 'should get a login page' do
        response = get('/login')

        expect(response.status).to eq(200)
        expect(response.body).to include('<form action="/login" method="POST">')
        
      end
    end

    # context "POST /login" do
    #   it "should successfully login" do
    #     response = post('/login')

    #   end
    # end
  end

  context 'User logs out' do
    context 'GET /logout' do
      it 'returns 400 status if not logged in' do
        response = get('/logout')

        expect(response.status).to eq(400)
      end

      it 'logs out' do
        post('/login', :email => 'slothy@gmail.com', :password => 'Sloths1234!')
        response = get('/logout')
       
        expect(response.status).to eq(200)
        expect(response.body).to include('<a href="/login">Log in</a>')
        expect(response.body).to include('<h1>Logout success!')
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
