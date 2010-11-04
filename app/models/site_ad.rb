class SiteAd < ActiveRecord::Base
  belongs_to :site
  belongs_to :ad

  validates_presence_of :site_id
  validates_uniqueness_of :ad_id, :scope => :site_id
end
