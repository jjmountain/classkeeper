class Course < ApplicationRecord
  belongs_to :user
  belongs_to :school
  belongs_to :faculty
  has_many :lessons
  has_many :course_periods, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  has_one :lessons_schedule
  accepts_nested_attributes_for :school
  accepts_nested_attributes_for :faculty
  accepts_nested_attributes_for :lessons, allow_destroy: true, reject_if: proc { |attr| attr['date'].blank? }

  
  validates :name, presence: true
  validates_associated :school
  validates_associated :faculty

end
