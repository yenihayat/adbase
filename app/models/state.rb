class State < ActiveRecord::Base
  has_many :ads
  has_many :zones
  has_many :sites
  has_many :users

  scope :users, where(:category_id => CONFIG['users_state_category_id'])
  scope :ads, where(:category_id => CONFIG['ads_state_category_id'])
  scope :sites, where(:category_id => CONFIG['sites_state_category_id'])
end
