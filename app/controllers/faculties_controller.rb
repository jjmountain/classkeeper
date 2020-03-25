class FacultiesController < ApplicationController
  def index
    school = School.includes(:faculties).find(params[:school_id])
    policy_scope(Faculty)
    render json: school.faculties.select(:name, :id).map { |f| { id: f.id, name: f.name }}
  end

  def create
    
  end

  def edit
    
  end

end