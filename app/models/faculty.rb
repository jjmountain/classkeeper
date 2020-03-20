class Faculty < ApplicationRecord
  belongs_to :school, optional: true
  has_many :periods
  has_many :courses, dependent: :destroy
  validates :name, presence: true, uniqueness: { scope: :school_id, message: 'That faculty already exists at this school' }
  accepts_nested_attributes_for :courses
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def self.select_values(school)
    return [] unless school
    school.faculties.pluck(:name, :id)
  end
end
