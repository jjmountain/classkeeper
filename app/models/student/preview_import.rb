class Student::PreviewImport
  include ActiveModel::Model
  attr_accessor :file, :course_id, :headers
  
  def initialize(attributes = {})
    @file = attributes[:file]
    @course_id = attributes[:course_id]
    @headers = attributes[:headers] == "1"
  end

  def read
    nested_array = CSV.read(@file)
    result = @headers ? nested_array.slice!(1..) : nested_array
    return result
  end

end