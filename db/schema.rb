# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170429061456) do

  create_table "applications", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
    t.integer  "course_number"
    t.integer  "semester_id"
    t.boolean  "validated"
  end

  create_table "courses", force: :cascade do |t|
    t.integer  "section"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.boolean  "grader_needed"
    t.integer  "course_number"
    t.boolean  "has_lab"
    t.integer  "semester_id"
    t.string   "semester"
    t.integer  "year"
  end

  create_table "grades_fors", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "section"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lab_times", force: :cascade do |t|
    t.string   "day"
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "lab_time_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "course_id"
  end

  create_table "recommendations", force: :cascade do |t|
    t.integer  "instructor_id"
    t.integer  "course_number"
    t.text     "comments"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "student_dot_number"
    t.string   "student_lname"
  end

  create_table "requests", force: :cascade do |t|
    t.integer  "course_number"
    t.integer  "section"
    t.string   "student_lname"
    t.integer  "student_dot_number"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "instructor_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.integer  "day",         null: false
    t.time     "start_time",  null: false
    t.time     "end_time",    null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.integer  "semester_id"
  end

  create_table "semesters", force: :cascade do |t|
    t.string   "semester"
    t.integer  "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "fname"
    t.string   "lname"
    t.integer  "dot_number"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "role"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "num_of_recommends"
  end

end
