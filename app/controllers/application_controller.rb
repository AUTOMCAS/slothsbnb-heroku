require "./config/environment"

class ApplicationController < Sinatra::Base

	configure do
		set :views, "app/views"
		enable :sessions
		register Sinatra::ActiveRecordExtension
	end

	get '/spaces' do
	  @spaces = Space.all
	  return erb(:spaces)
	end
end