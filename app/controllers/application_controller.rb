require "./config/environment"

class ApplicationController < Sinatra::Base

	configure do
		set :views, "views"
		enable :sessions
		register Sinatra::ActiveRecordExtension
	end

	get '/spaces' do
	   @spaces = Space.all
	   return erb(:spaces)
	end

	get '/' do
		return erb(:home)
 	end
end