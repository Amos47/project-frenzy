require 'test_helper'

class ProfessorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @professor = professors(:one)
  end

  test "should get new" do
    get new_professor_url
    assert_response :success
  end

  test "should create professor" do
    assert_difference('Professor.count') do
      post professors_url, params: {
        professor: {
          email: "p@test.com",
          name: "name",
          password: 'password',
          password_confirmation: 'password'
        }
      }
    end
    assert_redirected_to professor_url(Professor.last)
  end

  test "should show professor" do
    get professor_url(@professor)
    assert_response :success
  end

  test "should get edit" do
    login_with @professor
    get edit_professor_url(@professor)
    assert_response :success
  end

  test "should update professor" do
    login_with(@professor)
    patch professor_url(@professor), params: { professor: { name: "new name" } }
    assert_redirected_to professor_url(@professor)
  end

  test "should not update other professor" do
    login_with(professors(:two))
    assert_raises ActionController::RoutingError do
      patch professor_url(@professor), params: { professor: { name: "new name" } }
    end
  end

  test "should destroy professor" do
    login_with(@professor)
    assert_difference('Professor.count', -1) do
      delete professor_url(@professor)
    end
    assert_redirected_to login_path
  end

  test "should not destroy other professor" do
    login_with(professors(:two))
    assert_raises ActionController::RoutingError do
      delete professor_url(@professor), params: { professor: { name: "new name" } }
    end
  end
end
