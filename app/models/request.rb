class Request < ActiveRecord::Base

  validates :course_number, presence: true, numericality: {only_integer: true}
  validates :section, presence: true, numericality: {only_integer: true}
  validates :student_lname, presence: true, length: {maximum: 50}
  validates :student_dot_number, presence: true, numericality: {only_integer: true}

end
