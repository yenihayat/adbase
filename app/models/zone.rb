require 'uuidtools'

class Zone < ActiveRecord::Base
  before_create :set_uuid, :set_state

  belongs_to :site
  belongs_to :state

  has_many :ads, :through => :zone_ads do
    # Find active ads, and order them by their views count so we can serve each ad equal times.
    def find_active
      where(:state_id => CONFIG['state_ad_active']).order(:views_count)
    end
  end

  has_many :zone_ads, :dependent => :destroy
  accepts_nested_attributes_for :zone_ads, :reject_if => lambda { |a| a[:ad_id].blank? }, :allow_destroy => true

  scope :active, where(:state_id => CONFIG['state_zone_active'])

  validates_presence_of :name, :width, :height, :site_id

  private
    def set_uuid
      self.uuid = UUIDTools::UUID.random_create.to_s
    end

    def set_state
      self.state_id = CONFIG['state_zone_active']
    end
end
