
class Enrollment < ApplicationRecord
  belongs_to :course
  belongs_to :student
  validates :student_id, uniqueness: { scope: :course_id,
    message: "student is already enrolled in class" }
  
  def self.import(file, course_id)
    CSV.foreach(file.path, headers: true) do |row|
      kanji_name_array = row['学生氏名'].split('　')
      furigana_name_array = row['フリガナ'].split('　')
      english_name_array = row['Ｎａｍｅ'].split(' ')
      email = "#{row['学籍番号']}@s.obirin.ac.jp".downcase!
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
        'faculty': row['所属'].strip,
        'email': email,
        'password': row['学籍番号']
      }
      student = Student.find_or_create_by(student_number: row['学籍番号'], given_name: english_name_array[1], family_name: english_name_array[0]) do |student|
        student.password = row['学籍番号'],
        student.email = email,
        student.student_number = row['学籍番号']
      end
      student.update(student_hash)
      Enrollment.create(course_id: course_id, student_id: student.id) if student.persisted?
      puts "#{row['Ｎａｍｅ']} - #{student.errors.full_messages.join(',')}" if student.errors.any?
    end
  end
end
