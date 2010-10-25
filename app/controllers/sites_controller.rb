class SitesController < ApplicationController
  before_filter :authenticate_user!
  layout 'application'

  def index
    if current_user.is_admin?
      @sites = Site.all # TODO: Site.active olacak.
    else
      @sites = Site.active_and_current_users(current_user.id)
    end
  end

  def show
    @site = Site.find(params[:id])
  end

  def new
    @site = Site.new
    @users = User.all # TODO: Status'e göre çağrılacak.
  end

  def create
    @site = Site.new(params[:site])
    unless @site.user_id
      @site.user_id = current_user.id
    end

    if @site.save
      redirect_to new_zone_path(@site)
    else
      render :new
    end
  end
end
