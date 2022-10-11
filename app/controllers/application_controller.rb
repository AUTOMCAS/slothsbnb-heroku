require "./config/environment"

class ApplicationController < Sinatra::Base

	configure do
		set :views, "app/views"
		enable :sessions
	end

  get '/spaces/new' do
    return erb(:spaces_new)
  end
end