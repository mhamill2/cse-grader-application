module CoursesHelper

  # Sort @courses by course number ascending
  def sort_by_course
    @courses = @courses.sort_by &:course_number
  end

  # Sort @courses by section number ascending
  def sort_by_section
    @courses = @courses.sort_by &:section
  end

  # Sort @courses by grader_needed
  # List courses without a grader first
  def sort_by_grader_needs
    arr = []
    sort_by_course
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
    @courses = arr
  end

  def sort_by_grader_name
    #@courses = @courses.sort_by &:section
  end

  def get_graders(section)
    temp = GradesFor.all
    arr = []
    temp.each do |x|
      if x.section == section
        arr.push(User.find(x.user_id))
      end
    end
    return arr
  end

end
