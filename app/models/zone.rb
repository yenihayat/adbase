class Zone < ActiveRecord::Base
  belongs_to :site
  belongs_to :user
  belongs_to :state

  has_many :ads
end
