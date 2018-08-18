class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameter, if: :devise_controller?
  before_filter :configure_permitted_parameter, if: :devise_controller?
  protected

  def configure_permitted_parameter
  	devise_parameter_sanitizer.permit(:sign_in) do | user_params |
  		user_params.permit(:email)
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :current_password])
   	devise_parameter_sanitizer.permit(:sing_up, keys: [:emails, :password, :password_confirmaiton])
  end
  end
end