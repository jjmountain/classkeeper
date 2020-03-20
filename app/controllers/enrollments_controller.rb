class EnrollmentsController < ApplicationController

  def index
    @course = Course.find(params[:course_id])
    @enrollments = Enrollment.where(course_id: params[:course_id])
    # respond_to do |format|
    #   format.html
    #   format.csv { send_data @enrollments}
    # end
  end

  def import
    Enrollment.import(params[:file], params[:course_id].to_i)
    redirect_to course_path(params[:course_id]), notice: "Students imported"
  end
end
