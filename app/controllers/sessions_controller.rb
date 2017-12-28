class SessionsController < ApplicationController

  # Initializes a new session
  def new
  end

  # Creates a new login session
  def create
    var = params[:session] [:user_name] + "@osu.edu"
    user = User.find_by(email: var)
    if user && user.authenticate(params[:session] [:password])
      log_in user
      redirect_to home_url
    else
      #Display error message
      @error_message = "Invalid Username/Password Combination"
      @invalid = true
      render 'index'
    end
  end

  # Destroys the current session
  def destroy
    log_out
    redirect_to root_url
  end
end
