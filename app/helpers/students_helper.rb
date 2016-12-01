module StudentsHelper
  def professor_or_current_student?
    current_professor.present? || current_student_matches_id?
  end

  private

  def current_student_matches_id?
    current_student.present? && current_student.id.to_s == params[:id]
  end
end
