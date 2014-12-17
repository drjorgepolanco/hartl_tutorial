class SessionsController < ApplicationController
  def new
  end

  def create
  		# find the user by it's email in the db
  	user = User.find_by(email: params[:session][:email].downcase)
  		# if the user was found and the password was correct...
  	if user && user.authenticate(params[:session][:password])
  		# Log the user in and 
  		log_in user
  		# redirect to user's show page
  		redirect_to user
  	else
  		# Create an error message
  		# the method 'now' avoids the persistance of the message
  		flash.now[:danger] = 'Invalid email/password combination'
  		# Display the login form again
  		render 'new'
  	end
  end

  def destroy
  end
end
