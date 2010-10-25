class ApplicationController < ActionController::Base
  protect_from_forgery

  def require_admin
    unless current_user.is_admin?
      redirect_to destroy_user_session_path
    end
  end
end