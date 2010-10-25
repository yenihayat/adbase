class Site < ActiveRecord::Base
  belongs_to :user
  belongs_to :state

  has_many :zones
  has_many :ads
end
