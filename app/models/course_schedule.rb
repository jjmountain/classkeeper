class CourseSchedule < ApplicationRecord
  belongs_to :course
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :course_periods_exist
  validate :end_date_after_start_date, unless: Proc.new { |a| a.start_date.blank? || a.end_date.blank? }
  validate :course_period_on_end_date, unless: Proc.new { |a| a.end_date.blank? }
  validate :course_period_on_start_date, unless: Proc.new { |a| a.start_date.blank? }
  
  def end_date_after_start_date
    if end_date <= start_date
      errors.add(:end_date, "must be after first lesson")
    end
  end

  def course_periods_exist
    if course.course_periods.empty?
      errors[:base] << "You must create some lesson times above before you can schedule lessons"
    end
  end

  def course_period_on_start_date
    if course.course_periods.none? { |course_period| CoursePeriod::DAYS.index(course_period.day) == start_date.wday }
      errors.add(:start_date, "must be on a day with a lesson time")
    end
  end

  def course_period_on_end_date
    if course.course_periods.none? { |course_period| CoursePeriod::DAYS.index(course_period.day) == end_date.wday }
      errors.add(:end_date, "must be on a day with a lesson time")
    end
  end
end
