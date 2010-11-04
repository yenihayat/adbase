class ZonesController < ApplicationController
  before_filter :authenticate_user!
  layout 'application'

  def index
    if current_user.is_admin?
      @zones = Zone.active
    else
      @zones = current_user.sites.collect{ |site| site.zones }.flatten
    end
  end

  def show
    @zone = Zone.find(params[:id])
    redirect_to destroy_user_session_path unless belongs_to_user_site?
  end

  def new
    if current_user.has_active_site?
      @zone = Zone.new
      load_sites
    else
      set_flash(:first_create_a_site)
      redirect_to new_site_path
    end
  end

  def create
    @zone = Zone.new(params[:zone])

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
    def belongs_to_user_site?
      @site = Site.find(@zone.site_id)
      @site.users.include?(current_user) or current_user.is_admin?
    end

    def load_sites
      if current_user.is_admin?
        @sites = Site.active
      else
        @sites = current_user.sites.active
      end
    end

    def load_sites_ads
      if current_user.is_admin?
        @sites = Site.active
        @ads = Ad.active
      else
        @sites = current_user.sites.active
        @ads = Site.find(@zone.site_id).ads.active
      end

      build_ad_fields
    end

    # Build zone's ads. Default value can be changed from config/config.yml
    def build_ad_fields# :doc:
        missing_fields_count = CONFIG['edit_zone_ad_fields_count'] - @zone.zone_ads.length
        missing_fields_count.times { @zone.zone_ads.build }
    end
end
