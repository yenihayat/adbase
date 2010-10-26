class State < ActiveRecord::Base
  has_many :ads
  has_many :zones
  has_many :sites
  has_many :users
end
