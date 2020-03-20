class AddFieldsToStudents < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :given_name, :string
    add_column :students, :family_name, :string
    add_column :students, :student_number, :string
    add_column :students, :photo, :string
    add_column :students, :given_name_kanji, :string
    add_column :students, :given_name_furigana, :string
    add_column :students, :family_name_kanji, :string
    add_column :students, :family_name_furigana, :string
    add_column :students, :year_enrolled, :integer
    add_column :students, :gender, :string
  end
end
