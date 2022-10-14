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
		if logged_in?
			return erb(:error)
		else
	  	return erb(:login)
		end
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
	  	redirect "/"
		else
			return erb(:error)
		end
  end
  
  get '/spaces' do
		if logged_in?
			if params[:available_from] == nil
				@spaces = Space.all
			else 
				@spaces = Space.where(["available_from >= :available_from and available_to <= :available_to",
				{ available_from: params[:available_from], available_to: params[:available_to] }])
			end
			return erb(:spaces)
		else
	  	return erb(:error)
		end
	end

	get '/spaces/new' do
		if logged_in?
			return erb(:spaces_new)
		else
			return erb(:error)
		end
  end

	get '/spaces/:id' do
		if logged_in?
			@space_by_id = Space.find_by(id: params[:id])
			return erb(:space)
		else
			return erb(:error)
		end
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

	post '/spaces/:id' do
		@booking = Booking.new(
			user_id: current_user.id,
			space_id: params[:id],
			booking_date: params[:booking_date],
			pending_confirmation: true, 
			confirmed: false
		)
		if @booking.save
			redirect "/"
		else 
			return erb(:booking_failure)
		end
	end

	get '/signup' do
		if logged_in?
			return erb(:error)
		else
			return erb(:signup)
		end
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

	get '/requests' do
		@bookings = Booking.where(user_id: current_user.id)
		return erb(:requests)
	end

  private

  def logged_in?
    !!session[:user_id]
  end

  def current_user
    User.find(session[:user_id])
  end

	def get_todays_date
    date = Date.today 
    date.strftime "%Y-%m-%d"
  end

end