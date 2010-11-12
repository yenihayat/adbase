class UserSite < ActiveRecord::Base
  belongs_to :user
  belongs_to :site

  validates_presence_of :user_id
  validates_uniqueness_of :user_id, :scope => :site_id
end
