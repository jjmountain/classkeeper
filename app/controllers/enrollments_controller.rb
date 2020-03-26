class EnrollmentsController < ApplicationController

  def index
    @course = Course.find(params[:course_id])
    @import = Student::Import.new
    @enrollments = policy_scope(Enrollment.where(course_id: params[:course_id]))
    # respond_to do |format|
    #   format.html
    #   format.csv { send_data @enrollments}
    # end
  end

  def import
    @course = Course.find(params[:course_id])
    authorize @course
    @import = Student::Import.new(student_import_params)
    if @import.save
      redirect_to course_path(@course), notice: "Imported #{@import.imported_count} Students"
    else
      @enrollments = policy_scope(Enrollment.where(course_id: params[:course_id]))
      flash[:alert] = "There were #{@import.errors.count} errors with your CSV file"
      render action: :index
    end
  end

  private

  def student_import_params
    params.require(:student_import).permit(:file, :course_id)
  end
end
