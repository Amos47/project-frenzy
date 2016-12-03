 class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :take, :drop]
  before_action :authorize, except: [:show, :index]
  before_action :authorize_student, only: [:take, :drop]
  before_action :authorize_student_project, only: [:drop]
  before_action :authorize_professor, only: [:new, :create, :edit, :update, :destroy]
  before_action :authorize_professor_project, only: [ :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /projects/1/take
  # GET /projects/1/take.json
  def take
    respond_to do |format|
      if @project.update(student: current_student)
        format.html { redirect_to @project, notice: 'Project was successfully taken.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { redirect_to @project, flash: { error: @project.errors.full_messages.join("<br/>") } }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /projects/1/drop
  # GET /projects/1/drop.json
  def drop
    respond_to do |format|
      if @project.update(student: nil)
        format.html { redirect_to @project, notice: 'Project was successfully dropped.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { redirect_to @project, flash: { error: @project.errors.full_messages.join("<br/>") } }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def authorize_professor_project
      raise ActionController::RoutingError, 'Not Found' if current_professor.id != @project.professor_id
    end

    def authorize_student_project
      raise ActionController::RoutingError, 'Not Found' if current_student.id != @project.student_id
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:title, :description, :publish_at).merge(professor_id: current_professor.id)
    end
end
