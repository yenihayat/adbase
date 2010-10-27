require 'uuidtools'

class Zone < ActiveRecord::Base
  STATE_ACTIVE = 5
  STATE_PASSIVE = 6

  before_create :set_uuid, :set_state

  belongs_to :site
  belongs_to :user
  belongs_to :state

  has_many :ads, :through => :zone_ads
  has_many :zone_ads, :dependent => :destroy

  accepts_nested_attributes_for :zone_ads, :reject_if => lambda { |a| a[:ad_id].blank? }, :allow_destroy => true

  scope :active, where(:state_id => STATE_ACTIVE)
  scope :belongs_to_user, lambda { |user_id| { :conditions => ['user_id = ?', user_id] } }
  scope :belongs_to_site, lambda { |site_id| { :conditions => ['site_id = ?', site_id] } }

  validates_presence_of :name, :width, :height, :site_id
  
  private
    def set_uuid
      self.uuid = UUIDTools::UUID.random_create.to_s
    end

    def set_state
      self.state_id = STATE_ACTIVE
    end
end
