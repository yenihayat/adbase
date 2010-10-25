class Site < ActiveRecord::Base
  belongs_to :user
  belongs_to :state

  has_many :zones
  has_many :ads

  # TODO: named_scope :active, :conditions => ['state_id = ?', ACTIVE_SITE_STATE]
  named_scope :active_and_current_users, lambda { |current_user_id| { :conditions => ['user_id = ?', current_user_id] } }

  validates_presence_of :name, :url
  validates_uniqueness_of :name, :url
end