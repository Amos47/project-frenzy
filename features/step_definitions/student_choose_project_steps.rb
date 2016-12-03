Given "a student logs in" do
  @student = Student.find_by_email("s1@test.com")
  post login_url email: @student.email, password: "password"
end

When "the student requests an unattributed project" do
  @project = Project.where(student_id: nil).first
  get take_project_url(@project)
end

Then "the student is attributed on the project" do
  assert_equal @student, @project.reload.student
end

When "the student requests a project that's already been attributed" do
  @project = Project.first
  @other_student = Student.find_by_email("s2@test.com")
  @project.update!(student_id: @other_student.id)

  get take_project_url(@project)
end

Then "the student is not attributed on the project" do
  assert_equal @other_student, @project.reload.student
end
