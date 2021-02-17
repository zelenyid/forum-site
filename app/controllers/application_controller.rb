class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |_exception|
    respond_to do |format|
      format.html { page_not_found }
    end
  end

  def page_not_found
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end
end
