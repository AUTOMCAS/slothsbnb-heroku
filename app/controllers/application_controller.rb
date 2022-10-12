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

	get '/signup' do
    return erb(:signup)
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

	post '/signup' do
		@user = User.new(
		username: params[:username],
		email: params[:email],
		full_name: params[:full_name],
		password_digest: params[:password_digest],
		phone_number: params[:phone_number]
		)
    return erb(:signup)
  end

end