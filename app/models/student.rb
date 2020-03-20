class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :photo
  validates :student_number, presence: true
  validates :given_name, presence: true
  validates :family_name, presence: true
  has_many :attendances
  has_many :enrollments, dependent: :destroy
  has_many :courses, through: :enrollments

  def full_name
    "#{given_name} #{family_name}"
  end

  def full_name_kanji
    "#{family_name_kanji} #{given_name_kanji}"
  end

  def schools
    enrollments.map { |enrollment| enrollment.course.school } 
  end


  # return all the lessons that the student is enrolled in
  # lesson belongs to a course, a course has many enrollments, and enrollments have student ids
  def lessons
    Lesson.joins(course: [ { enrollments: :student } ]).where(enrollments: { student_id: id })
  end


  def self.online
    ids = ActionCable.server.pubsub.redis_connection_for_subscriptions.smembers "online"
    where(id: ids)
  end
end
