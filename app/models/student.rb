class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :photo
  validates :student_number, presence: true, uniqueness: true
  validates :given_name, presence: true
  validates :family_name, presence: true
  has_many :attendances
  has_many :enrollments, dependent: :destroy
  has_many :courses, through: :enrollments
  before_save :capitalize_names

  def self.assign_from_row(row)
    student = Student.where(student_number: row['学籍番号']).first_or_initialize
    kanji_name_array = row['学生氏名'].split('　') unless row['学生氏名'].nil?
    furigana_name_array = row['フリガナ'].split('　') unless row['フリガナ'].nil?
    english_name_array = row['Ｎａｍｅ'].split(' ') unless row['Ｎａｍｅ'].nil?
    email = "#{row['学籍番号']}@s.obirin.ac.jp".downcase
    year = row[0]
    student_hash = {
      'given_name': english_name_array[1],
      'family_name': english_name_array[0],
      'given_name_furigana': furigana_name_array[1],
      'family_name_furigana': furigana_name_array[0],
      'given_name_kanji': kanji_name_array[1],
      'family_name_kanji': kanji_name_array[0],
      'student_number': row['学籍番号'],
      'year_enrolled': year,
      'email': email,
      'password': row['学籍番号']
    }
      student.update_attributes(student_hash)
      student
  end

  def capitalize_names
    given_name.capitalize!
    family_name.capitalize!
  end

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
