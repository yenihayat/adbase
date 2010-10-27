class SitesController < ApplicationController
  before_filter :authenticate_user!
  layout 'application'

  def index
    if current_user.is_admin?
      @sites = Site.active
    else
      @sites = Site.active.belongs_to_user(current_user.id)
    end
  end

  def show
    @site = Site.find(params[:id])
  end

  def new
    @site = Site.new
    @users = User.active
  end

  def create
    @site = Site.new(params[:site])
    unless @site.user_id and current_user.is_admin?
      @site.user_id = current_user.id
    end
  
    if @site.save
      redirect_to site_path(@site)
    else
      @users = User.active
      render :new
    end
  end

  def edit
    @site = Site.find(params[:id])
    @users = User.active
  end

  def update
    @site = Site.find(params[:id])
    if @site.update_attributes(params[:site])
      redirect_to site_path(@site)
    else
      @users = User.active
      render :edit
    end
  end
end
