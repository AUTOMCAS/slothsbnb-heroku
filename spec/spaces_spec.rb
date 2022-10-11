require_all
require 'capybara/dsl'

Capybara.app = ApplicationController

describe ApplicationController do
  include Rack::Test::Methods

  let(:app) { ApplicationController.new }

  before(:each) do
    reset_test_data
  end

    context 'GET /spaces' do
      it 'returns 200 OK and displays list' do
        response = get('/spaces')
          expect(response.status).to eq(200)
          expect(response.body).to include('List of Sloth spaces:')
          expect(response.body).to include('Name:')
          expect(response.body).to include('Description:')
          expect(response.body).to include('Price Per Night:')
          expect(response.body).to include('Available from:')
          expect(response.body).to include('Available to:')
      end

      it 'returns 200 OK and shows all spaces' do
        response = get('/spaces')
          expect(response.status).to eq(200)
          expect(response.body).to include('List of Sloth spaces:')
          expect(response.body).to include('Slothspace1')
          expect(response.body).to include('Homely sloth den')
          expect(response.body).to include('£20.00')
          expect(response.body).to include('10/10/22')
          expect(response.body).to include('11/10/22')
      end
    end

    def reset_test_data
      Space.destroy_all
      Space.create(user_id: 1, space_name: "Sloth Space", description: "Warm Sloth den, with lots of worms to eat", price_per_night: 20, available_from: "10/10/2022", available_to: "11/10/2022")
      Space.create(user_id: 1, space_name: "Slothy Apartment", description: "High-rise working sloth bachelor pad", price_per_night: 30, available_from: "17/09/2022", available_to: "18/09/2022")
      Space.create(user_id: 2, space_name: "Sloth Cave", description: "Rural, open plan Sloth safe space", price_per_night: 10, available_from: "15/08/2022", available_to: "16/08/2022")
    end
end






