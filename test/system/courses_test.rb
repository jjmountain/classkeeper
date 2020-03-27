require "application_system_test_case"

class CoursesTest < ApplicationSystemTestCase
  setup do
    @course = courses(:chuo_course)
  end
  test "faculties select is populated with faculties when clicking on a school" do
    sign_in users(:james)
    visit new_course_url
    select('Chuo University', from: 'School')
    assert_equal('Global Management', find_field('Faculty').text)
  end

  test "can create a course" do
    sign_in users(:james)
    visit new_course_url
    select('Chuo University', from: 'School')
    select('Global Management', from: 'Faculty')
    fill_in 'Course Name', with: 'Academic English'
    fill_in 'Classroom', with: 'J601'
    fill_in 'Class Number', with: '11'
    select('Writing', from: 'Class Focus')
    click_on "Create Course"
    assert_selector "h1", text: 'Academic English'
  end

  test "can edit and update a course" do
    sign_in users(:james)
    visit course_url(@course)
    click_link('edit-course')
    fill_in 'Course Name', with: 'Conversational English'
    click_on 'Update Course'
    assert_selector "h1", text: 'Conversational English'
  end
end
