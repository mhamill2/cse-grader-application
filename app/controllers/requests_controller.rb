class RequestsController < ApplicationController

  # Initializes a new request
  def new
    @request = Request.new
  end

  # Creates a new grader request
  def create
    @request = Request.new(request_params)
    @request.instructor_id = current_user.id
    if @request.save
      redirect_to home_url
    else
      render 'new'
    end
  end

  #View all the requests from the table
  def view_requests
    @requests = Request.all
    render 'requests/view_requests'
  end

  #Show a request for a student. 
  def show
    @request = Request.find(params[:format])
    @user = User.find_by_lname_and_dot_number(@request.student_lname.capitalize, @request.student_dot_number)

  end

  private

  # Required parameters for a request
  def request_params
    params.require(:request).permit(:course_number, :section, :student_lname, :student_dot_number)
  end

end
