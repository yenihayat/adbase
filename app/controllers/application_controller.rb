class ApplicationController < ActionController::Base
  # Default ad fields count in ZonesController#edit
  EDIT_ZONE_DEFAULT_AD_FIELDS_COUNT = 5

  protect_from_forgery

  def require_admin
    unless current_user.is_admin?
      redirect_to destroy_user_session_path
    end
  end
end