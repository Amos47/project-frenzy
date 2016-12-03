class Project < ApplicationRecord
  belongs_to :professor
  belongs_to :student, optional: true
  validate :student_cannot_null_if_updating_student, on: :update
  validates :student, uniqueness: { message: 'already has a project, drop that before taking another one.' }, if: 'student.present?'


  def student_cannot_null_if_updating_student
    if student_id_changed? && student_id_was.present? && student_id.present?
      errors.add(:student_id, 'has already taken this project, please choose another project')
    end
  end
end
