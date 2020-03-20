# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_20_025025) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendances", force: :cascade do |t|
    t.bigint "lesson_id", null: false
    t.bigint "enrollment_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["enrollment_id"], name: "index_attendances_on_enrollment_id"
    t.index ["lesson_id"], name: "index_attendances_on_lesson_id"
  end

  create_table "course_periods", force: :cascade do |t|
    t.bigint "period_id", null: false
    t.bigint "course_id", null: false
    t.integer "day"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_course_periods_on_course_id"
    t.index ["period_id"], name: "index_course_periods_on_period_id"
  end

  create_table "course_schedules", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.bigint "course_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_course_schedules_on_course_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.bigint "faculty_id", null: false
    t.bigint "user_id", null: false
    t.string "class_type"
    t.string "classroom"
    t.string "description"
    t.boolean "archived"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["faculty_id"], name: "index_courses_on_faculty_id"
    t.index ["user_id"], name: "index_courses_on_user_id"
  end

  create_table "enrollments", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "student_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_enrollments_on_course_id"
    t.index ["student_id"], name: "index_enrollments_on_student_id"
  end

  create_table "faculties", force: :cascade do |t|
    t.string "name"
    t.bigint "school_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["school_id"], name: "index_faculties_on_school_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.bigint "course_schedule_id", null: false
    t.bigint "course_period_id", null: false
    t.date "date"
    t.integer "week"
    t.boolean "complete"
    t.boolean "holiday"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_period_id"], name: "index_lessons_on_course_period_id"
    t.index ["course_schedule_id"], name: "index_lessons_on_course_schedule_id"
  end

  create_table "periods", force: :cascade do |t|
    t.bigint "faculty_id", null: false
    t.time "start_time"
    t.integer "minutes"
    t.integer "period_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["faculty_id"], name: "index_periods_on_faculty_id"
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "students", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "given_name"
    t.string "family_name"
    t.string "student_number"
    t.string "photo"
    t.string "given_name_kanji"
    t.string "given_name_furigana"
    t.string "family_name_kanji"
    t.string "family_name_furigana"
    t.integer "year_enrolled"
    t.string "gender"
    t.index ["email"], name: "index_students_on_email", unique: true
    t.index ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "given_name"
    t.string "family_name"
    t.string "photo"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "attendances", "enrollments"
  add_foreign_key "attendances", "lessons"
  add_foreign_key "course_periods", "courses"
  add_foreign_key "course_periods", "periods"
  add_foreign_key "course_schedules", "courses"
  add_foreign_key "courses", "faculties"
  add_foreign_key "courses", "users"
  add_foreign_key "enrollments", "courses"
  add_foreign_key "enrollments", "students"
  add_foreign_key "faculties", "schools"
  add_foreign_key "lessons", "course_periods"
  add_foreign_key "lessons", "course_schedules"
  add_foreign_key "periods", "faculties"
end
