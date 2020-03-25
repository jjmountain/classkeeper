class AddClassNumberToCourse < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :class_number, :string
  end
end
