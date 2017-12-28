class SemestersController < ApplicationController

  # Initializes a new semester
  def new
    @semester = Semester.new
  end

  # Creates a new semester
  def create
    @semester = Semester.new(semester_params)
    if @semester.save
      @semester = Semester.new
      @success = true
      redirect_to manage_semesters_url
      #Handle save course
    else
      render 'users/admin/manage_semesters'
    end
  end

  # Renders the manage_semesters page if the user is an admin
  def manage_semesters
    if logged_in?
      if current_user.role == "admin"
        render 'users/admin/manage_semesters'
      else
        render 'access_denied'
      end
    else
      redirect_to root_url
    end
  end

  #Removes a semester, useful for cleanup way down the road.
  def destroy
    Semester.find(params[:format]).destroy
    redirect_to manage_semesters_url
  end

  private

  # Required parameters for semester
  def semester_params
    params.require(:semester).permit(:year, :semester)
  end

end
