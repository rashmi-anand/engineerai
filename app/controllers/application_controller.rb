class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, :alert => exception.message
  end


  def after_sign_in_path_for(user)
    if current_user.admin?
      secret_codes_path
    else    	
    	user_path(current_user)
    end
  end

  def after_sign_out_path_for(user)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first,:last, :email, :password, :uniq_code, :user_secret_code])
  end
end
