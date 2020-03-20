class Lesson < ApplicationRecord
  belongs_to :course_schedule
  belongs_to :course_period
end
