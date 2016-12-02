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

  def current_user_profile_path
    if current_student.present?
      student_path(current_student)
    elsif current_professor.present?
      professor_path(current_professor)
    else
      Rails.logger.error("Current user profile path called with no user")
      login_path
    end
  end
  helper_method :current_user_profile_path

  def authorize
    raise ActionController::RoutingError.new('Not Found') unless current_student || current_professor
  end

  def authorize_professor
    raise ActionController::RoutingError.new('Not Found') if current_professor.nil?
  end
end
