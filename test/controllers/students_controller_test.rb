require 'test_helper'

class StudentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @student = students(:one)
    @professor = professors(:one)
  end

  test "should get index when logged in with professor" do
    login_with(@professor)
    get students_url
    assert_response :success
  end

  test "should not get index when not professor" do
    login_with(@student)
    assert_raises ActionController::RoutingError do
      get students_url
    end
  end

  test "should get new" do
    get new_student_url
    assert_response :success
  end

  test "should create student" do
    assert_difference('Student.count') do
      post students_url, params: {
        student: {
          email: 's@test.com', name: 'Student',
          password: 'password', password_confirmation: 'password'
        }
      }
    end

    assert_redirected_to '/'
  end

  test "should show student if logged in with that student" do
    login_with(@student)
    get student_url(@student)
    assert_response :success
  end

  test "should show student if logged in with professor" do
    login_with(@professor)
    get student_url(@student)
    assert_response :success
  end

  test "should not show student if logged in with another student" do
    login_with(students(:two))
    assert_raises ActionController::RoutingError do
      get student_url(@student)
    end
  end

  test "should not show student if not logged in" do
    assert_raises ActionController::RoutingError do
      get student_url(@student)
    end
  end

  test "should get edit if logged in with student" do
    login_with(@student)
    get edit_student_url(@student)
    assert_response :success
  end

  test "should get edit if logged in with professor" do
    login_with(@professor)
    get edit_student_url(@student)
    assert_response :success
  end

  test "should not get edit if logged in with another student" do
    login_with(students(:two))
    assert_raises ActionController::RoutingError do
      get edit_student_url(@student)
    end
  end

  test "should update student if logged in as student" do
    login_with(@student)
    original_digest = @student.password_digest
    patch student_url(@student), params: {
      student:
      {
        email: @student.email, name: @student.name,
        password: 'new_password', password_confirmation: 'new_password'
      }
    }
    assert_redirected_to student_url(@student)
    assert_not_equal original_digest, @student.reload.password_digest
  end

  test "should update student if logged in as professor" do
    login_with(@professor)
    original_digest = @student.password_digest
    patch student_url(@student), params: {
      student:
      {
        email: @student.email, name: @student.name,
        password: 'new_password', password_confirmation: 'new_password'
      }
    }
    assert_redirected_to student_url(@student)
    assert_not_equal original_digest, @student.reload.password_digest
  end

  test "should not update student if logged in with another student" do
    login_with(students(:two))
    original_digest = @student.password_digest
    assert_raises ActionController::RoutingError do
      patch student_url(@student), params: {
        student:
        {
          email: @student.email, name: @student.name,
          password: 'new_password', password_confirmation: 'new_password'
        }
      }
    end
    assert_equal original_digest, @student.reload.password_digest
  end

  test "should destroy student if logged in with student" do
    login_with(@student)
    assert_difference('Student.count', -1) do
      delete student_url(@student)
    end

    assert_redirected_to login_path
  end

  test "should destroy student if logged in with professor" do
    login_with(@professor)
    assert_difference('Student.count', -1) do
      delete student_url(@student)
    end

    assert_redirected_to login_path
  end

  test "should destroy student if logged in with another student" do
    login_with(students(:two))
    assert_raises do
      delete student_url(@student)
    end
  end
end
