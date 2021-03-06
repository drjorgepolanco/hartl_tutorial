class SessionsController < ApplicationController
  def new
  end

  # Before account activation. Anybody can log in after sign up
  # def create
  # 		# find the user by it's email in the db
  # 	user = User.find_by(email: params[:session][:email].downcase)
  # 		# if the user was found and the password was correct...
  # 	if user && user.authenticate(params[:session][:password])
  # 		# Log the user in and 
  # 		log_in user
  #     # remember user token to allow session persistence upon browser closing
  #     # remember user
  #     params[:session][:remember_me] == '1' ? remember(user) : forget(user)
  # 		# redirect to user's show page
  # 		redirect_back_or user
  # 	else
  # 		# Create an error message
  # 		# the method 'now' avoids the persistance of the message
  # 		flash.now[:danger] = 'Invalid email/password combination'
  # 		# Display the login form again
  # 		render 'new'
  # 	end
  # end

  # With account activation: Only activated users can log in
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message = "Account not activated."
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = "Invalid email/password combination"
      render 'new'
    end
  end


  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
