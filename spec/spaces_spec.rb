require "spec_helper"
require "rack/test"
require_all 'app'
require "json"
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
          expect(response.body).to include('Slothy Apartment')
          expect(response.body).to include('High-rise working sloth bachelor pad')
          expect(response.body).to include('30.0')
          expect(response.body).to include('2022-09-17')
          expect(response.body).to include('2022-09-18')
      end

      it 'returns 200 OK and shows all spaces' do
        response = get('/spaces')
          expect(response.status).to eq(200)
          expect(response.body).to include('Sloth Cave')
          expect(response.body).to include('Rural, open plan Sloth safe space')
          expect(response.body).to include('10.0')
          expect(response.body).to include('2022-08-15')
          expect(response.body).to include('2022-08-16')
      end
    end

    def reset_test_data
      Space.destroy_all
      Space.create(user_id: 1, space_name: "Sloth Space", description: "Warm Sloth den, with lots of worms to eat", price_per_night: 20, available_from: "10/10/2022", available_to: "11/10/2022")
      Space.create(user_id: 1, space_name: "Slothy Apartment", description: "High-rise working sloth bachelor pad", price_per_night: 30, available_from: "17/09/2022", available_to: "18/09/2022")
      Space.create(user_id: 2, space_name: "Sloth Cave", description: "Rural, open plan Sloth safe space", price_per_night: 10, available_from: "15/08/2022", available_to: "16/08/2022")
    end
end






