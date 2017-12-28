class Semester < ActiveRecord::Base

  validates :year, presence: true, numericality: {only_integer: true}
  validates :semester, presence: true

end
