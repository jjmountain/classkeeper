class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update]

  def index
    @courses = Course.where(user: current_user)
  end

  def show
    authorize @course
    @enrollments = Enrollment.where(course_id: params[:id])
    @lessons = @course.lessons
  end

  def new
    @course = Course.new
    authorize @course
  end

  def create
    @course = Course.new(course_params)
    @course.user = current_user 
    if @course.save
      # set the faculty school id because form doesn't update it
      @course.faculty.school_id = @course.school_id
      @course.faculty.save
      redirect_to course_path(@course)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @course = Course.find(params[:id])
    @course.update(course_params)
    if @course.save
      respond_to do |format|
        # an html request means the user is actually editing the course or adding lessons
        format.html { redirect_to course_path(@course), notice: 'Course successfully updated!' }
        # a ajax request means they are creating lessons
        format.js do
        end
      end
    else
      render 'edit'
    end
    authorize @course
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    redirect_to courses_path
  end
  
  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:school_id, :faculty_id, :name, :description, :start_date, :end_date, :class_type, :classroom, :class_number, :lessons_per_week, :weeks_per_course, faculty_attributes: [:id, :name, :max_absences, :school_id], school_attributes: [:id, :name], lessons_attributes: [:_destroy, :id, :date, :objective, :course_period_id, :holiday, :week, :lessons_schedules_id] )
  end
end
