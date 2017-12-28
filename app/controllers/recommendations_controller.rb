class RecommendationsController < ApplicationController

  # Initializes a new recommendation
  def new
    @recommendation = Recommendation.new
  end

  # Creates a new recommendation
  def create
    @recommendation = Recommendation.new(recommendation_params)
    @recommendation.instructor_id = current_user.id
    email = "#{params[:recommendation][:student_lname].downcase}.#{params[:recommendation][:student_dot_number]}@osu.edu"
    if (User.find_by_email(email) != nil)
      if @recommendation.save
        User.find_by_email(email).increment!(:num_of_recommends)
        redirect_to home_url
      else
        render 'new'
      end
    else
      @not_valid = true
      render 'new'
    end
  end

  #Views all of the recommendations
  def view_recommendations
    @recommendations = Recommendation.all
    render 'recommendations/view_recommendations'
  end

  #Show a recommendation for student
  def show
    @recommendation = Recommendation.find(params[:format])
    @user = User.find_by_lname_and_dot_number(@recommendation.student_lname.capitalize, @recommendation.student_dot_number)

  end


  private

  # Required parameters for recommendation
  def recommendation_params
    params.require(:recommendation).permit(:student_dot_number, :student_lname, :instructor_id, :course_number, :comments)
  end

end
