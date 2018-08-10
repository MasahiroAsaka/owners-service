class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :configure_admin_user,only: [:create], if: :devise_controller?

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name])
    end

    def configure_admin_user
      redirect_to '/plans/new' if current_owner.try(:admin?)
    end
end
