class AdsController < ApplicationController
  before_filter :authenticate_user!
  layout 'application'

  def index
    if params[:site_id]
      @ads = Ad.active.belongs_to_site(params[:site_id])
    else
      if current_user.is_admin?
        @ads = Ad.active
      else
        @ads = Ad.active.belongs_to_user(current_user.id)
      end
    end
  end

  def show # TODO: Clean up.
    @ad = Ad.find(params[:id],
      :joins => "LEFT JOIN zones ON zones.id = ads.zone_id",
      :select => "ads.*, zones.name as zone_name")
  end

  def new
    @ad = Ad.new

    if current_user.is_admin?
      @zones = Site.active.with_zones
    else
      @zones = Zone.active.belongs_to_user(curret_user.id).with_zones
    end
  end

  def create
    @ad = Ad.new(params[:ad])
    unless @ad.user_id
      @ad.user_id = current_user.id # TODO before_create
    end

    @zone = Zone.find(@ad.zone_id)

    if @zone 
      @ad.site_id = @zone.site_id
    end

    if @ad.save
      redirect_to ad_path(@ad)
    else
      if current_user.is_admin?
        @zones = Site.active.with_zones
      else
        @zones = Zone.active.belongs_to_user(curret_user.id).with_zones
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
