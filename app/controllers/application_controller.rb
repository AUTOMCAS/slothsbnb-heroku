require "./config/environment"

class ApplicationController < Sinatra::Base

	configure do
		set :views, "app/views"
		enable :sessions
	end
  
  get '/' do
		return erb(:index)
 	end

  get '/login' do
	  return erb(:login)
  end

	post '/login' do
		@user = User.find_by(email: params[:email])

		if @user && @user.authenticate(params[:password])
			session[:user_id] = @user.id
			redirect '/'
		else
			return erb(:login_failure)
		end
	end

	get '/logout' do
		if logged_in?
			session.clear
	  	return erb(:logout)
		else
			status 400
		end
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
      user_id: current_user.id,
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
		password: params[:password],
		phone_number: params[:phone_number]
		)
    return erb(:signup)
  end

  private

  def logged_in?
    !!session[:user_id]
  end

  def current_user
    User.find(session[:user_id])
  end

end