class LessonsSchedulesController < ApplicationController
  before_action :set_lessons_schedule, only: [:destroy]
  
  def create
    @lessons_schedule = LessonsSchedule.new(lessons_schedule_params)
    authorize @lessons_schedule
    @lessons_schedule.course_id = params[:course_id]
    @course = Course.find(params[:course_id])
    if @lessons_schedule.save 
       @dates_array = CalculateSchedule.call(@lessons_schedule)
    end
  end

  def destroy
    authorize @lessons_schedule
    if @lessons_schedule.destroy
      @course = @lessons_schedule.course
      respond_to do |format|
        format.js { flash[:notice] = "Your Lessons Schedule was destroyed" }
      end
    end
  end

  private

  def lessons_schedule_params
    params.require(:lessons_schedule).permit(:start_date, :end_date, :course_id)
  end

  def set_lessons_schedule
    @lessons_schedule = LessonsSchedule.find(params[:id])
  end
end
