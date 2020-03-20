
class CoursePeriodsController < ApplicationController
  def create
    skip_authorization
    @course_period = CoursePeriod.new(
      day: course_period_params[:day].to_i,
      course_id: course_period_params[:course_id],
      period_id: course_period_params[:period_id]
    )
    @course = Course.find(params[:course_period][:course_id])
    @faculty = @course.faculty
    if @course_period.save
      respond_to do |format|
        format.js
      end
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    @course_period = CoursePeriod.find(params[:id])
    authorize @course_period
    @course_period.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def course_period_params
    params.require(:course_period).permit(:day, :period_id, :course_id)
  end
end
