class CreateLessons < ActiveRecord::Migration[6.0]
  def change
    create_table :lessons do |t|
      t.references :course_schedule, null: false, foreign_key: true
      t.references :course_period, null: false, foreign_key: true
      t.date :date
      t.integer :week
      t.boolean :complete
      t.boolean :holiday

      t.timestamps
    end
  end
end
