class School < ApplicationRecord
  has_many :faculties
  has_many :courses, through: :faculties
end
