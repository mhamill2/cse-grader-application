class GradesForsController < ApplicationController

  #Creates a new grades for relationship.
  def new
    @section = params[:section]
    @grades_for = GradesFor.new
    @user = User.all
  end

  #Similiar to new, but a bit more logic behind it.  This method makes sure that graders are needed.
  def create
    @grades_for = GradesFor.new(grades_for_params)
    if Course.find_by_section(params[:grades_for][:section]).grader_needed == true
      Course.find_by_section(params[:grades_for][:section]).toggle!(:grader_needed)
    end
    @grades_for.save
    redirect_to course_list_url
  end

  #Removes a gradesfor row from the table.
  def destroy
    GradesFor.find_by_section_and_user_id(params[:section], params[:user_id]).destroy
    if GradesFor.find_by_section(params[:section]) == nil
      Course.find_by_section(params[:section]).toggle!(:grader_needed)
    end
    redirect_to course_list_url
  end

  def show
  end
  
  private

  # Required parameters for grades_for
  def grades_for_params
    params.require(:grades_for).permit(:section, :user_id)
  end

end
