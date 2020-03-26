class EnrollmentsController < ApplicationController
  skip_after_action :verify_authorized, only: [ :preview_import ]

  def index
    @course = Course.find(params[:course_id])
    @preview_import = Student::PreviewImport.new
    @import = Student::Import.new
    @enrollments = policy_scope(Enrollment.where(course_id: params[:course_id]))
  end

  def preview_import
    @preview_import = Student::PreviewImport.new(preview_import_params)
    respond_to do |format|
      format.js
    end
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

  def preview_import_params
    params.require(:student_preview_import).permit(:file, :course_id, :headers)
  end
end
