class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_student
    @current_student ||= Student.find(session[:student_id]) if session[:student_id]
  end
  helper_method :current_student

  def current_professor
    @current_professor ||= Professor.find(session[:professor_id]) if session[:professor_id]
  end
  helper_method :current_professor

  def authorize
    redirect_to login_path unless current_student || current_professor
  end

  def authorize_professor
    redirect_to '/' if current_student.present?
    redirect_to login_professors_path if current_professor.nil?
  end
end
