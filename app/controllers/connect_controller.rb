class ConnectController < ApplicationController
  layout false

  def index
    @uuids = extract_uuids(params[:ids])
    @zones = Zone.find(:all,
      :joins => "LEFT JOIN zone_ads ON zone_ads.zone_id = zones.id LEFT JOIN ads ON ads.id = zone_ads.ad_id",
      :select => "zones.uuid AS uuid, ads.ad_file_name AS ad_file_name, ads.target_url AS ad_target_url, ads.id AS ad_id",
      :group => "zones.id",
      :conditions => ["zones.uuid IN (?)", @uuids])
  end

  private
    def extract_uuids(ids)
      ids.scan(/.{1,36}/m)
    end
end
