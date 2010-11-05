class AdsController < ApplicationController
  before_filter :authenticate_user!
  layout 'application'

  def index
    if current_user.is_admin?
      @ads = Ad.active
    else
      @ads = current_user.sites.collect{ |site| site.ads }.flatten
    end
  end

  def show # TODO: Check if user has permission...
    @ad = Ad.find(params[:id])
  end

  def new
    @ad = Ad.new
    load_sites
  end

  def create
    @ad = Ad.new(params[:ad])
    if @ad.save
      set_flash(:ad_created)
      redirect_to ad_path(@ad)
    else
      load_sites
      render :new
    end
  end

  def edit
    @ad = Ad.find(params[:id])
    load_sites
  end

  def update
    @ad = Ad.find(params[:id])

    if @ad.update_attributes(params[:ad])
      set_flash(:ad_updated)
      redirect_to ad_path(@ad)
    else
      load_sites
      render :edit
    end
  end

  private
    def new_content?
      ! params[:ad]['ad'].nil?
    end

    def load_sites
      if current_user.is_admin?
        @sites = Site.active
      else
        @sites = current_user.sites
      end
      @states = State.ads

      build_site_fields
    end

    def build_site_fields
      missing_fields_count = CONFIG['site_fields_count'] - @ad.site_ads.length
      missing_fields_count.times { @ad.site_ads.build }
    end
end
