# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.create([
	{ fname: "Admin", lname: 'Admin', dot_number: 1, email: "admin.1@osu.edu", password: "Password123", role: 2},
	{ fname: "Michael", lname: 'Hamill', dot_number: 33, email: "hamill.33@osu.edu", password: "Password123", role: 0, num_of_recommends: 0},
	{ fname: "John", lname: 'Doe', dot_number: 201, email: "doe.201@osu.edu", password: "Password123", role: 0, num_of_recommends: 0},
	{ fname: "Goijko", lname: 'Babic', dot_number: 1, email: "babic.1@osu.edu", password: "Password123", role: 1},
	{ fname: "Michael", lname: 'Myers', dot_number: 9, email: "myers.9@osu.edu", password: "Password123", role: 0, num_of_recommends: 0},
	{ fname: "Zach", lname: 'Zachory', dot_number: 29, email: "zachary.29@osu.edu", password: "Password123", role: 0, num_of_recommends: 0},
	{ fname: "Paul", lname: 'Sivilotti', dot_number: 5, email: "sivilotti.5@osu.edu", password: "Password123", role: 1},
	{ fname: "That", lname: 'Guy', dot_number: 40, email: "guy.40@osu.edu", password: "Password123", role: 0, num_of_recommends: 0}
	])

semesters = Semester.create([
	{semester: "Summer", year: 2017},
	{semester: "Fall", year: 2017},
	{semester: "Spring", year: 2018}
	])

courses = Course.create([
	{course_number: 2241, section: 1234, semester_id: 2},
	{course_number: 2242, section: 8789, semester_id: 2},
	{course_number: 3901, section: 1457, semester_id: 3},
	{course_number: 3902, section: 8478, semester_id: 3},
	{course_number: 3903, section: 6453, semester_id: 3},
	{course_number: 2221, section: 8834, semester_id: 3},
	{course_number: 5341, section: 1000, semester_id: 3},
	{course_number: 3231, section: 1523, semester_id: 3},
	{course_number: 4331, section: 3412, semester_id: 3}
	])

applications = Application.create([
  {user_id: 2, course_number: 2241, semester_id: 2},
  {user_id: 2, course_number: 2242,  semester_id: 2},
  {user_id: 3, course_number: 2241, semester_id: 2},
  {user_id: 5, course_number: 2241, semester_id: 2},
  {user_id: 5, course_number: 2221, semester_id: 3}
	])

