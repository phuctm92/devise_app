class ApplicationController < ActionController::Base
  include Error

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username email password password_confirmation])
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[login password remember_me])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[username email password password_confirmation current_password])
  end
end
