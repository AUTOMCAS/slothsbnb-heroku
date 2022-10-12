require "./config/environment"

class ApplicationController < Sinatra::Base

	configure do
		set :views, "app/views"
		enable :sessions
	end
  
  get '/' do
		return erb(:home)
 	end
  
  get '/spaces' do
	   @spaces = Space.all
	   return erb(:spaces)
	end
 
  get '/spaces/new' do
    return erb(:spaces_new)
  end

	post '/spaces/new' do
		@space = Space.new(
			space_name: params[:space_name],
			description: params[:description] ,
			price_per_night: params[:price_per_night],
			available_to: params[:available_to],
			available_from: params[:available_from]
		)
		
		return erb(:spaces_new)
	end

end