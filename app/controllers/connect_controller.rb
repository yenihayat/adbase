class ConnectController < ApplicationController
  layout false

  def index
    @ad = Ad.find(:first,
      :joins => "LEFT JOIN zones ON zones.id = ads.zone_id",
      :conditions => ["zones.uuid = ?", params[:uuid]],
      :select => "zones.uuid, ads.*")
  end
end
