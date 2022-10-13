require "spec_helper"
require "rack/test"
require_all 'app'
require "json"

describe ApplicationController do
  include Rack::Test::Methods

  let(:app) { ApplicationController.new }

    context 'GET /spaces' do
      it 'returns 200 OK and displays list' do
        response = get('/spaces')
          expect(response.status).to eq(200)
          expect(response.body).to include('SLOTHY APARTMENT')
          expect(response.body).to include('High-rise working sloth bachelor pad')
          expect(response.body).to include('£30.0')
          expect(response.body).to include('2022-09-17')
          expect(response.body).to include('2022-09-18')
      end

      it 'returns 200 OK and shows all spaces' do
        response = get('/spaces')
          expect(response.status).to eq(200)
          expect(response.body).to include('SLOTH CAVE')
          expect(response.body).to include('Rural, open plan Sloth safe space')
          expect(response.body).to include('£10.0')
          expect(response.body).to include('2022-08-15')
          expect(response.body).to include('2022-08-16')
      end
    end
end

