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

  def show
    @zone = Zone.find(params[:id])
  end

  def new
    if current_user.has_active_site?
      @zone = Zone.new
      load_sites
    else
      flash[:alert] = "You have to create a site before creating a zone." # TODO: set_flash_message
      redirect_to new_site_path
    end
  end

  def create
    @zone = Zone.new(params[:zone])
    @site = Site.find(@zone.site_id)
    @zone.user_id = @site.user_id if @site

    if @zone.save
      set_flash(:zone_created)
      redirect_to edit_zone_path(@zone)
    else
      load_sites
      render :new
    end
  end

  def edit
    @zone = Zone.find(params[:id])
    load_sites_ads
  end

  def update
    @zone = Zone.find(params[:id])
    if @zone.update_attributes(params[:zone])
      set_flash(:zone_updated)
      redirect_to zone_path(@zone)
    else
      load_sites_ads
      render :edit
    end
  end

  private
    def load_sites
      if current_user.is_admin?
        @sites = Site.active
      else
        @sites = Site.active.belongs_to_user(curret_user.id)
      end
    end

    def load_sites_ads
      if current_user.is_admin?
        @sites = Site.active
        @ads = Ad.active
      else
        @sites = Site.active.belongs_to_user(curret_user.id)
        @ads = Ad.active.belongs_to_user(curret_user.id)
      end

      build_ad_fields
    end

    # FIXME
    def build_ad_fields
      if @zone.zone_ads.length < CONFIG['edit_zone_ad_fields_count']
        if @ads.length <= CONFIG['edit_zone_ad_fields_count']
          missing_fields_count = @ads.length - @zone.zone_ads.length
        else
          missing_fields_count = CONFIG['edit_zone_ad_fields_count'] - @zone.zone_ads.length
        end
        missing_fields_count.times { @zone.zone_ads.build }
      end
    end
end
