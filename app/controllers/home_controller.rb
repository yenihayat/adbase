class HomeController < ApplicationController
  layout 'sessions'

  def index
    if current_user
      redirect_to dashboard_path
    end
  end
end