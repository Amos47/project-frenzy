class Project < ApplicationRecord
  belongs_to :professor
  belongs_to :student, optional: true

  validates :student, uniqueness: true, if: 'student.present?'
end
