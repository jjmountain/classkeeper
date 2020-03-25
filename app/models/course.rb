class Course < ApplicationRecord
  belongs_to :faculty
  belongs_to :user
  has_many :lessons, through: :course_schedules
  has_many :course_periods, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  has_many :course_schedules
  # accepts_nested_attributes_for :school
  # accepts_nested_attributes_for :faculty
  accepts_nested_attributes_for :lessons, allow_destroy: true, reject_if: proc { |attr| attr['date'].blank? }
  validates :name, presence: true
  validates_associated :school
end
