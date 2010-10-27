class State < ActiveRecord::Base
  # State Id Categories
  # Defined in lib/tasks/bootstrap.rake
  USERS_CATEGORY_ID = 100
  SITES_CATEGORY_ID = 200
  ZONES_CATEGORY_ID = 300
  ADS_CATEGORY_ID = 400

  has_many :ads
  has_many :zones
  has_many :sites
  has_many :users

  scope :users, where(:category_id => USERS_CATEGORY_ID)
  scope :ads, where(:category_id => ADS_CATEGORY_ID)
  scope :sites, where(:category_id => SITES_CATEGORY_ID)
end
