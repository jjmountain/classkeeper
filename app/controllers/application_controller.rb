class ApplicationController < ActionController::Base
  
  # Devise config 
  protect_from_forgery with: :exception
  devise_group :member, contains: [:student, :user]

  # authenticate for either a user or a student
  before_action :authenticate!

  def authenticate!
    :authenticate_user! || :authenticate_student!
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(
      :sign_up, keys: [
        :given_name, 
        :family_name, 
        :given_name_furigana, 
        :family_name_furigana,
        :given_name_kanji,
        :family_name_kanji,
        :student_number,
        :photo,
        :year_enrolled,
        :gender
      ]
    )

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(
      :account_update, keys: [
      :given_name, 
      :family_name, 
      :given_name_furigana, 
      :family_name_furigana,
      :given_name_kanji,
      :family_name_kanji,
      :student_number,
      :photo,
      :year_enrolled,
      :gender
    ]
  )
  end

  protected

  def after_sign_in_path_for(resource)
    # return the path based on resource
    pages_dashboard_path
  end

  def after_sign_out_path_for(scope)
    # return the path based on scope
    root_path
  end

  # Pundit config

  include Pundit

  def pundit_user
    current_user || current_student
  end

  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

end
