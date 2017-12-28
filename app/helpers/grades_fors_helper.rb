module GradesForsHelper

  def find_valid_graders(section)
    course = Course.find_by_section(section).course_number
    apps = Application.all
    valid_graders = []
    apps.each do |x|
      if x.course_number == course
        if GradesFor.find_by_user_id(User.find(x.user_id)) == nil
          valid_graders.push User.find(x.user_id)
        end
      end
    end
    valid_graders = valid_graders.uniq
    return valid_graders
  end

end
