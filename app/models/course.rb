class Course < ActiveRecord::Base

  after_initialize :set_default_needed, :if => :new_record?

  def set_default_needed
    self.grader_needed = true
  end

  validates :course_number, presence: true, numericality: {only_integer: true}
  validates :section, presence: true, numericality: {only_integer: true}, uniqueness: true


  
end
