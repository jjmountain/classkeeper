class CoursePeriod < ApplicationRecord
  DAYS = ['Sun', 'Mon', 'Tues', 'Wed', 'Thurs', 'Fri', 'Sat']
  belongs_to :course
  belongs_to :period
  has_many :lessons
  enum day: DAYS
  validates :day, presence: true
  validates :period_id, uniqueness: { scope: :day, message: 'and period are already selected' }
  scope :ordered, -> { 
    order(:day).joins(:period).merge(Period.order(:period_number))
   }
end
