class Site < ActiveRecord::Base
  before_create :set_state

  has_many :users, :through => :user_sites
  has_many :user_sites
  accepts_nested_attributes_for :user_sites, :reject_if => lambda { |a| a[:user_id].blank? }, :allow_destroy => true

  has_many :ads, :through => :site_ads
  has_many :site_ads

  has_many :zones
  accepts_nested_attributes_for :zones

  belongs_to :state

  scope :active, where(:state_id => CONFIG['state_site_active'])
  # scope :that_has_zone, lambda { |zone_id| { where() } }

  validates_presence_of :name, :url
  validates_uniqueness_of :url

  private
    def set_state
      self.state_id = CONFIG['state_site_active']
    end
end