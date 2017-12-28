class Recommendation < ActiveRecord::Base
  validates :student_lname, presence: true, length: {maximum: 50}
  validates :student_dot_number, presence: true, numericality: {only_integer: true}
  validates :course_number, presence: true, numericality: {only_integer: true}

end
