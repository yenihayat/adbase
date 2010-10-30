class ConnectController < ApplicationController
  layout false
  require 'uri'

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
  end

  def redirect
    @ad = Ad.find_by_target_url(params[:u]) # TODO: Should be something uniq!
    if @ad.track_clicks?
      @ad.update_attribute(:clicks_count, (@ad.clicks_count + 1))
    end
    redirect_to "#{@ad.target_url}"
  end

  private
    def extract_uuids(ids)
      ids.scan(/.{1,36}/m)
    end
end
