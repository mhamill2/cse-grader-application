module SessionsHelper

  # Creates a session for user
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns the current user
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Checks if user is the current_user
  def current_user?(user)
    user == current_user
  end

  # Checks if current_user is logged in
  def logged_in?
    !current_user.nil?
  end

  # Destroys the current session
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

end
