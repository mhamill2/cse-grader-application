class User < ActiveRecord::Base

	VALID_PASSWORD_REGEX = /\A(?=.*[a-zA-Z])(?=.*[0-9]).{8,}\Z/
	enum role: [:student, :instructor, :admin]

  validates :fname, presence: true, length: {maximum: 50}
  validates :lname, presence: true, length: {maximum: 50}
  validates :dot_number, presence: true, numericality: {only_integer: true}
  validates :role, presence: true 
  validates :email, presence: true, length: { maximum: 255 },
                    uniqueness: {case_sensitive: false}

  has_secure_password
  validates :password, format: { with: VALID_PASSWORD_REGEX }, allow_blank: true
  has_many :applications, dependent: :destroy
  validates :dot_number, numericality: {only_integer: true}

  #validates :email_matches_name_dot

  has_many :applications, dependent: :destroy
  has_many :schedules, dependent: :destroy

  before_save { self.email = email.downcase }


end
