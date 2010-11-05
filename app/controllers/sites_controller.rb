class SitesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_admin, :except => [:index, :show]
  layout 'application'

  def index
    if current_user.is_admin?
      @sites = Site.active
    else
      @sites = current_user.sites.active
    end
  end

  def show
    @site = Site.find(params[:id])
    redirect_to destroy_user_session_path unless current_users?
  end

  # Only admin is allowed to add site.
  def new
    @site = Site.new
    load_users_for_admin
  end

  def create
    @site = Site.new(params[:site])

    if @site.save
      set_flash(:site_created)
      redirect_to site_path(@site)
    else
      load_users_for_admin
      render :new
    end
  end

  def edit
    @site = Site.find(params[:id])
    load_users_for_admin
  end

  def update
    @site = Site.find(params[:id])
    if @site.update_attributes(params[:site])
      set_flash(:site_updated)
      redirect_to site_path(@site)
    else
      load_users_for_admin
      render :edit
    end
  end

  private
    def current_users?
      @site.users.include?(current_user) or current_user.is_admin?
    end

    def load_users_for_admin
      if current_user.is_admin?
        @users = User.active
        build_site_users
      end
    end

    def build_site_users
      missing_fields_count = CONFIG['user_sites_fields_count'] - @site.user_sites.length
      missing_fields_count.times { @site.user_sites.build }
    end
end
