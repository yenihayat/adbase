# Controls traffic between publisher site and AdBase. Validates incoming ad requests and serves them in <tt>views_count</tt> order.
class ConnectController < ApplicationController
  layout false
  require 'uri'

  # Collect and craft javascript ad data.
  def index
    @uuids = extract_uuids(params[:ids])
    @zones = Zone.find_all_by_uuid(@uuids)

    @ads = []
    for zone in @zones
      ad = zone.ads.find_active.first
      ad.zone_uuid = zone.uuid
      ad.update_attribute(:views_count, (ad.views_count + 1))
      @ads << ad
    end
    respond_to do |format|
      format.js
    end
  end

  # Save clicks count and redirect request to <tt>ad.target_url</tt> 
  def out
    @ad = Ad.find(params[:id])
    if @ad.track_clicks?
      @ad.update_attribute(:clicks_count, (@ad.clicks_count + 1))
    end
    redirect_to "#{@ad.target_url}"
  end

  private
    # Convert uuid parameter string to array by dividing per 36 chars.
    def extract_uuids(ids) # :doc:
      ids.scan(/.{1,36}/m)
    end
end
