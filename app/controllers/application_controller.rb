class ApplicationController < ActionController::Base
  before_action :authenticate_client!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name address phone_number])
  end

  def after_sign_in_path_for(resource)
    client_path(resource)
  end
end
