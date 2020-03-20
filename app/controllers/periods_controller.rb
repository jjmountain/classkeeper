require 'pry'
class PeriodsController < ApplicationController

  def create
    @course_period = CoursePeriod.new
    @course = Course.find(params[:period][:course])
    @period = Period.new(period_params)
    @faculty = @period.faculty
    @period.save
    authorize @period
  end

  def destroy
    @period = Period.find(params[:id])
    if @period.destroy
      respond_to do |format|
        format.js
      end
    end
    authorize @period
  end

  private

  def period_params
    params.require(:period).permit(:period_number, :start_time, :minutes, :faculty_id)
  end
end
