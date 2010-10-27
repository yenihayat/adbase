module AdsHelper
  def expire_status_message(ad)
    if ad.expire?
      if ad.max_clicks_count > 0 and ad.max_views_count > 0
        "Set to expire on " + ad.max_views_count.to_s + " views or " + ad.max_clicks_count.to_s + " clicks."
      elsif ad.max_clicks_count > 0
        "Set to expire on " + ad.max_clicks_count.to_s + " clicks"
      elsif ad.max_views_count > 0
        "Set to expire on " + ad.max_views_count.to_s + " views"
      else
        "Set to expire on date: <strong>".html_safe + l(ad.expire_at, :format => :short) + "</strong>".html_safe
      end
    else
      "Not set to expire."
    end
  end

  def tracking_status_message(ad)
    if ad.track_clicks? and ad.track_views?
      "Tracking both views and clicks."
    elsif ad.track_clicks?
      "Tracking only clicks."
    elsif ad.track_views?
      "Tracking only views."
    else
      "Not tracking."
    end
  end

  def hide_unless_set_to_expire(expire)
    unless expire
      "style='display: none;'"
    end
  end
end
