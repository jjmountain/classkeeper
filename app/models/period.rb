class Period < ApplicationRecord
  belongs_to :faculty
  has_many :course_periods, dependent: :destroy
  validates :minutes, numericality: { only_integer: true, greater_than: 0 }
  validates :minutes, presence: true
  validates :start_time, presence: true
  validates :period_number, presence: true
  validates :period_number, uniqueness: { scope: :faculty_id }, numericality: { only_integer: true, less_than: 13 }
  validate :periods_not_overlapping
  before_destroy :check_period_not_in_use

  def class_time
    "#{start_time.strftime('%H:%M')} - #{end_time.strftime('%H:%M %P')}".strip()
  end

  def end_time
    start_time + minutes.minutes
  end

  def check_period_not_in_use
    # look through course periods where course id is the same as the period 
    if CoursePeriod.where.not(period_id: id).empty?
      errors.add(:id, "Period is currently in use in a course")
    end
end
