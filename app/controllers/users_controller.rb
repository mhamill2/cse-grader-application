class UsersController < ApplicationController
  
  # Initializes a new user
  def new
    @user = User.new
  end

  # Gets the user information
  def show
    @user = User.find(params[:format])
  end

  #renders evaluation page.
  def grader_evaluation
    render 'users/instructor/grader_evaluation'
  end

  #Adjust account setting, i.e. password changes.
  def edit
    @user = User.find(params[:format])
    render 'users/account_settings'
  end

  #Updates a user, adds a new email.
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to home_url
    else
      redirect_to account_settings_url(@user)
    end
  end

  #Renders the add_admin page, a quick way to get to a view/form.
  def add_admin
    render 'users/admin/add_admin'
  end

  #Checks for password match, and if they do, adds a new admin to the table.
  def create_admin
    @password = params[:new_admin][:password]
    password2 = params[:new_admin][:password2]

    if(@password != password2)
      @password_bad = true
      redirect_to add_admin_url()
      return
    end

    @first_name = params[:new_admin][:first_name]
    @last_name = params[:new_admin][:last_name]
    @dot_number = params[:new_admin][:dot_number]
    @email = @last_name + "." + @dot_number + "osu.edu"

    User.create(role: :admin, fname: @first_name, lname: @last_name, dot_number: @dot_number, email: @email, password: @password)

    redirect_to home_url
  end

  # Creates a new user and redirects to the home url
  def create
    @user = User.new(user_params)
    @user.role = params[:user][:role].to_i
    @user.email = "#{@user.lname}.#{@user.dot_number}@osu.edu"
    if @user.role == "student"
      @user.num_of_recommends = 0
    end
    if @user.save
      log_in @user
      redirect_to home_url
    else
      render 'new'
    end
  end

  # Renders the home page for the current user
  def home
    if logged_in?
      if current_user.role == "admin"
        @courses = Course.all
        @recommendations = Recommendation.all
        @requests = Request.all
        arr = []
        @courses.each do |c|
          if c.grader_needed
            arr.push c
          end
        end
        @courses = arr
        @courses.sort_by &:course_number
        render 'users/admin/home'
      elsif current_user.role == "student"
        if Application.find_by_user_id(current_user.id).blank? == false
          @applications = Application.where(user_id: current_user.id)
        else
          @applications = []
        end
        render 'users/student/home'
      elsif current_user.role == "instructor"
        render 'users/instructor/home'
      end
    else 
      redirect_to root_url
    end
  end

  # Renders the user_list page
  def user_list
    @users = User.all
    if params.has_key?(:user_list)
      if params[:user_list][:sort_method].downcase == "user type"
        @users = @users.sort_by &:role
      elsif params[:user_list][:sort_method].downcase == "first name"
        @users = @users.sort_by &:fname
      else
        @users = @users.sort_by &:email
      end
    end
    if logged_in?
      if current_user.role == "admin"
        render 'users/admin/user_list'
      else
        redirect_to access_denied_url
      end
    else
      redirect_to root_url
    end
  end

  # Renders the access denied page
  def access_denied
    render 'access_denied'
  end

  # Renders the remove_user page
  def remove_user
    if logged_in?
      if current_user.role == "admin"
        render 'users/admin/remove_user'
      else
        render 'access_denied'
      end
    else
      redirect_to root_url
    end
  end

  # Deletes the user passed through params
  def destroy
    User.find(params[:format]).destroy
    redirect_to user_list_url
  end

  private

  # Required parameters for user
  def user_params
    params.require(:user).permit(:fname, :lname, :password, :password_confirmation, :dot_number)
  end
end
