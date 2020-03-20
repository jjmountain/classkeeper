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

  def periods_not_overlapping
    Period.where(faculty_id: faculty_id).each do |existing_period|
      # check that the period start time doesn't overlap with the existing period
      if self.start_time.strftime("%H%M%S") >= existing_period.start_time.strftime("%H%M%S") && self.start_time.strftime("%H%M%S") <= existing_period.end_time.strftime("%H%M%S")
        errors.add(:start_time, "must not overlap with existing period")
      elsif self.end_time.strftime("%H%M%S") >= existing_period.start_time.strftime("%H%M%S") && self.end_time.strftime("%H%M%S") <= existing_period.end_time.strftime("%H%M%S")
        # check that the period end time doesn't overlap with the existing period
        errors.add(:start_time, "must not overlap with existing period")
      end
    end
  end
end
