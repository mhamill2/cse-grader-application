class Schedule < ActiveRecord::Base

	enum day: [:monday, :tuesday, :wednesday, :thrusday, :friday]

	belongs_to :user
end
