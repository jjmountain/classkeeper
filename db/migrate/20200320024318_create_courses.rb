class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.references :faculty, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :class_type
      t.string :classroom
      t.string :description
      t.boolean :archived

      t.timestamps
    end
  end
end
