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
      # remember user token to allow session persistence upon browser closing
      # remember user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
  		# redirect to user's show page
  		redirect_back_or user
  	else
  		# Create an error message
  		# the method 'now' avoids the persistance of the message
  		flash.now[:danger] = 'Invalid email/password combination'
  		# Display the login form again
  		render 'new'
  	end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
