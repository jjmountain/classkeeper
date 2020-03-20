class SchoolsController < ApplicationController
  def new
    @school = School.new
  end

  def create
    @school = School.new(school_params)
    @school.user = current_user
    if @school.save
      redirect_to pages_dashboard_path, notice: "School created"
    else 
      render 'new'
    end
  end

  private

  def school_params
    params.require(:school).permit(:name, :faculty )
  end
end
