class School < ApplicationRecord
  has_many :faculties, dependent: :destroy
  has_many :courses

  validates :name, presence: true, uniqueness: true

  def self.select_value
    School.all.map { |school| [school.name, school.id, { data: { url: data_url(school) }}] }
  end


  private

  def self.data_url(school)
    Rails.application.routes.url_helpers.school_faculties_path(school, format: :json)
  end
end
