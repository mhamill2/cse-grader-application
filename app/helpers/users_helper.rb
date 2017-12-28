module UsersHelper

  def sort_by_first_name
  end

  def sort_by_lname_dot_num
  end

  def sort_by_user_type
    @users = @users.sort_by &:role
  end

end
