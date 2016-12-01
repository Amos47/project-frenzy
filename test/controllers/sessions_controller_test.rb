require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should new get show the login page" do
    get login_url
    assert_response :success
  end

  test "should post create logs in a student and redirects to projects index" do
    student = Student.create!(name: "name", email: "s@test.com", password: 'password', password_confirmation: 'password')
    post login_url, params: { email: "s@test.com", password: 'password' }
    assert_equal student.id, session[:student_id]
    assert_redirected_to "/"
  end

  test "should post create logs in a professor and redirects to projects index" do
    professor = Professor.create!(name: "name", email: "p@test.com", password: 'password', password_confirmation: 'password')
    post login_url, params: { email: "p@test.com", password: 'password', professor_login: true }
    assert_equal professor.id, session[:professor_id]
    assert_redirected_to "/"
  end

  test "should get destroy and destroy all sessions" do
    get login_url
    session[:professor_id] = "123"
    session[:student_id] = "123"
    get logout_url
    assert_nil session[:professor_id]
    assert_nil session[:student_id]
    assert_redirected_to login_url
  end

end
