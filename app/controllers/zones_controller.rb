class ZonesController < ApplicationController
  before_filter :authenticate_user!
  layout 'application'

  def index
    if params[:site_id]
      @zones = Zone.active.belongs_to_site(params[:site_id])
    else
      if current_user.is_admin?
        @zones = Zone.active
      else
        @zones = Zone.active.belongs_to_user(current_user.id)
      end
    end
  end

  def show # TODO: Clean up.
    @zone = Zone.find(params[:id],
      :joins => "LEFT JOIN sites ON sites.id = zones.site_id",
      :select => "zones.*, sites.name as site_name")
  end

  def new
    if Site.exists?(:user_id => current_user.id)
      @zone = Zone.new

      if current_user.is_admin?
        @sites = Site.active
      else
        @sites = Site.active.belongs_to_user(curret_user.id)
      end
    else
      flash[:alert] = "You have to create a site before creating a zone." # TODO: set_flash_message
      redirect_to new_site_path
    end
  end

  def create
    @zone = Zone.new(params[:zone])
    unless @zone.user_id
      @zone.user_id = current_user.id
    end

    @site = Site.find(@zone.site_id)

    if @site 
      @zone.user_id = @site.user_id
    end

    if @zone.save
      redirect_to zone_path(@zone)
    else
      if current_user.is_admin?
        @sites = Site.active
      else
        @sites = Site.active.belongs_to_user(curret_user.id)
      end
      render :new
    end
  end

  def edit
    @zone = Zone.find(params[:id])

    if current_user.is_admin?
      @sites = Site.active
    else
      @sites = Site.active.belongs_to_user(curret_user.id)
    end
  end

  def update
    @zone = Zone.find(params[:id])
    if @zone.update_attributes(params[:zone])
      redirect_to zone_path(@zone)
    else
      if current_user.is_admin?
        @sites = Site.active
      else
        @sites = Site.active.belongs_to_user(curret_user.id)
      end

      render :edit
    end
  end
end
