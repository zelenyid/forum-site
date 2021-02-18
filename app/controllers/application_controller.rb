class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |_exception|
    respond_to do |format|
      format.html { page_not_found }
    end
  end

  def page_not_found
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:avatar, :email, :password, :password_confirmation, :current_password)
    end
  end
end
