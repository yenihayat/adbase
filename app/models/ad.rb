class Ad < ActiveRecord::Base
  belongs_to :zone
  belongs_to :site
  belongs_to :user
  belongs_to :state
end
