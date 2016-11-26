class SessionsController < ApplicationController
  def new
  end

  def create
    user_type = if params[:professor_login]
      Professor
    else
      Student
    end

    user = user_type.find_by_email(params[:email])
    if user.present? && user.authenticate(params[:password])
      if user_type == Professor
        session[:professor_id] = user.id
      else
        session[:student_id] = student.id
      end
      redirect_to '/'
    else
      redirect_to '/login'
    end
  end

  def destroy
    session[:student_id] = nil
    session[:professor_id] = nil
    redirect_to '/login'
  end
end
