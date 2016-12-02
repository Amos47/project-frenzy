class Project < ApplicationRecord
  belongs_to :professor
  belongs_to :student, optional: true
  validate :student_cannot_null_if_updating_student, on: :update
  validates :student, uniqueness: true, if: 'student.present?'


  def student_cannot_null_if_updating_student
    if student_id_changed? && student_id_was.present?
      errors.add(:student_id, 'You have chosen an already attributed project, please choose another project')
    end
  end
end
