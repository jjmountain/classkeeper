# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


puts 'destroying users'
User.destroy_all

puts 'destroying schools'
School.destroy_all

puts "Creating Teachers (users)"
User.create!(
  given_name: 'James',
  family_name: 'Devereux',
  email: 'freewaytofluency@gmail.com',
  password: 'secret'
)

puts "Creating Schools"

School.create!(
  name: 'J.F Oberlin University'
)

School.create!(
  name: 'Chuo University'
)

puts "Creating Faculties"

Faculty.create!(
  name: 'Business Management',
  school: School.first
)

Faculty.create!(
  name: 'Literature',
  school: School.first
)

Faculty.create!(
  name: 'Global Management',
  school: School.second
)