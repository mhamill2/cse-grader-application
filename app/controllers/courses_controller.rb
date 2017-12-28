class CoursesController < ApplicationController

  @success = false

  # Initializes a new course
  def new
    @course = Course.new
  end

  # Renders the course_list page
  def course_list
    @courses = Course.all
    if params.has_key?(:course_list)
      @semester = params[:course_list][:semester]
      arr = @semester.split
      semester = Semester.find_by_semester_and_year(arr[0], arr[1]).id
      @courses = Course.where(semester_id: semester)
      if params[:course_list][:sort_method].downcase == "course name"
        @courses = @courses.sort_by &:course_number
      elsif params[:course_list][:sort_method].downcase == "section number"
        @courses = @courses.sort_by &:section
      elsif params[:course_list][:sort_method].downcase == "grader needs"
        arr = []
        @courses = @courses.sort_by &:course_number
        @courses.each do |course|
          if course.grader_needed
            arr.push course
          end
        end
        @courses.each do |course|
          unless course.grader_needed
            arr.push course
          end
        end
        @courses.clear
        @courses = arr
      end
    else
      @courses = @courses.sort_by &:course_number
    end
    if logged_in?
      if current_user.role == "admin"
        render 'courses/course_list'
      else
        render 'access_denied'
      end
    else
      redirect_to root_url
    end
  end

  # Displays information about a course given a particular id.
  def show
    @course = Course.find(params[:id])
  end

  # Deletes a course from the database
  def destroy
    Course.find(params[:id]).destroy
    redirect_to course_list_url
  end

  # Creates a new course, used in replace of new.  
  def create
    if logged_in?
      if current_user.role = "admin"
        @semester = params[:course][:semester]
        #Getting the semester into a format that can be used to pull the id from the database
        #We decided to do this in controller instead of in view, seemd to make more sense.
        arr = @semester.split
        @semester = Semester.find_by_semester_and_year(arr[0], arr[1]).id
        #Create the new course with the correct semester selected.
        @course = Course.new(course_params)
        @course.semester_id = @semester
        #Determines if the course has a lab.
        if params[:course][:has_lab].to_i > 0
          @course.has_lab = true
        else
          @course.has_lab = false
        end
        if @course.save
          @name = @course.course_number
          if @course.has_lab
            redirect_to add_lab_time_url
          else
            @course = Course.new
            @success = true
            render 'new'
          end
          #Handle save course
        else
          render 'new'
        end
      else
        redirect_to access_denied_url
      end
    else
      redirect_to root_url
    end
  end

  private

  # Required course parameters
  def course_params
    params.require(:course).permit(:course_number, :section, :has_lab)
  end
end
