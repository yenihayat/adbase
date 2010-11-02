class ApplicationController < ActionController::Base
  protect_from_forgery

  def require_admin
    unless current_user.is_admin?
      redirect_to destroy_user_session_path
    end
  end

  # Set message. Default type is notice.
  def set_flash(name, type=nil)
    type ||= 'notice'
    flash[type] = t(name)
  end
end