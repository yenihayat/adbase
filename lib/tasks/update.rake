namespace :update do
  AD_STATE_EXPIRED = 8

  desc "Update ad states by checking their expiration variables."
  task :ad_states => :environment do
    @ads = Ad.where(:expire => 1)
    @ads.each do |ad|
      if ad.max_views_count == 0 and ad.max_clicks_count == 0
        ad.update_attribute(:state_id, AD_STATE_EXPIRED) if ad.expire_at < DateTime.now
      elsif ad.max_views_count == 0 and ad.max_clicks_count > 0
        ad.update_attribute(:state_id, AD_STATE_EXPIRED) if (ad.max_clicks_count >= ad.clicks_count) or (ad.expire_at < DateTime.now)
      elsif ad.max_views_count > 0 and ad.max_clicks_count == 0
        ad.update_attribute(:state_id, AD_STATE_EXPIRED) if (ad.max_views_count >= ad.views_count) or (ad.expire_at < DateTime.now)
      end
    end
  end

  desc "Run all bootstrapping tasks."
  task :all => [:ad_states]
end