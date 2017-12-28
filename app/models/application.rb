class Application < ActiveRecord::Base

	enum grade: ["A", "A-", "B+", "B", "B-", "C+", "C", "C-", "D+", "D", "D-", "E", "I"]
	validates :user_id, presence: true
	validate :test_valid
	belongs_to :user

	def test_valid
		user = User.find_by_id(user_id)
		if user == nil
			errors.add(:base, 'Invalid user.')
		end
	end

end