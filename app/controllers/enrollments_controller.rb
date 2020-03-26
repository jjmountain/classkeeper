class EnrollmentsController < ApplicationController

  def index
    @course = Course.find(params[:course_id])
    @enrollments = policy_scope(Enrollment.where(course_id: params[:course_id]))
    # respond_to do |format|
    #   format.html
    #   format.csv { send_data @enrollments}
    # end
  end

  def import
    @course = Course.find(params[:course_id])
    authorize @course
    count = Enrollment.import(params[:file], params[:course_id])
    redirect_to course_path(@course), notice: "Imported #{count} Students"
  end
end
