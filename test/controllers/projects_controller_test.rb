require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = projects(:one)
    @professor = professors(:one)
    @student = students(:one)
  end

  test "should get index" do
    get projects_url
    assert_response :success
  end

  test "should get new when logged in as professor" do
    login_with(@professor)
    get new_project_url
    assert_response :success
  end

  test "should not get new when logged in as student" do
    login_with(@student)
    assert_raises ActionController::RoutingError do
      get new_project_url
    end
  end

  test "should not get new when not logged in" do
    assert_raises ActionController::RoutingError do
      get new_project_url
    end
  end

  test "should create project when logged in with professor" do
    login_with(@professor)
    assert_difference('Project.count') do
      post projects_url, params: {
        project: {
          description: "A really long description",
          publish_at: Time.now.utc,
          title: "Great title! The best title!"
        }
      }
    end

    assert_redirected_to project_url(Project.last)
  end

  test "should not create project when logged in with student" do
    login_with(@student)
    assert_raises ActionController::RoutingError do
      post projects_url, params: {
        project: {
          description: "A really long description",
          publish_at: Time.now.utc,
          title: "Great title! The best title!"
        }
      }
    end
  end

  test "should not create project when not logged in" do
    assert_raises ActionController::RoutingError do
      post projects_url, params: {
        project: {
          description: "A really long description",
          publish_at: Time.now.utc,
          title: "Great title! The best title!"
        }
      }
    end
  end

  test "should show project" do
    get project_url(@project)
    assert_response :success
  end

  test "should get edit if professor" do
    login_with(@professor)
    get edit_project_url(@project)
    assert_response :success
  end

  test "should not get edit if student" do
    login_with(@student)
    assert_raises ActionController::RoutingError do
      get edit_project_url(@project)
    end
  end

  test "should update project if professor" do
    login_with(@professor)
    patch project_url(@project), params: {
      project: {
        description: @project.description,
        publish_at: @project.publish_at,
        title: @project.title
        }
      }
    assert_redirected_to project_url(@project)
  end

  test "should not update project if student" do
    login_with(@student)
    assert_raises ActionController::RoutingError do
      patch project_url(@project), params: {
        project: {
          description: @project.description,
          publish_at: @project.publish_at,
          title: @project.title
          }
        }
      end
  end

  test "should destroy project if professor" do
    login_with(@professor)
    assert_difference('Project.count', -1) do
      delete project_url(@project)
    end

    assert_redirected_to projects_url
  end

  test "should not destroy project if student" do
    login_with(@student)
    assert_raises ActionController::RoutingError do
      delete project_url(@project)
    end
  end

  test "should take when logged in with student" do
    login_with(@student)
    get take_project_url(@project)
    assert_redirected_to @project
  end

  test "should not take when project already has student" do
    other_student = students(:two)
    @project.update!(student: other_student)
    login_with(@student)
    get take_project_url(@project)
    assert_redirected_to @project
    assert_equal other_student, @project.reload.student
  end

  test "should not take when professor" do
    login_with(@professor)
    assert_raises ActionController::RoutingError do
      get take_project_url(@project)
    end
  end

  test "should drop when student" do
    login_with(@student)
    @project.update!(student: @student)
    get drop_project_url(@project)
    assert_redirected_to @project
  end

  test "should not drop for other student" do
    login_with(@student)
    @project.update!(student: students(:two))
    assert_404 do
      get drop_project_url(@project)
    end
  end
end
