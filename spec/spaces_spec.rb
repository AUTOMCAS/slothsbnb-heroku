require_all
require 'capybara/dsl'

Capybara.app = ApplicationController

describe ApplicationController do
  include Rack::Test::Methods

  let(:app) { ApplicationController.new }

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
end






