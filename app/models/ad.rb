class Ad < ActiveRecord::Base
  before_create :randomize_file_name, :set_state
  before_save :randomize_file_name

  has_many :zones, :through => :zone_ads
  has_many :zone_ads

  belongs_to :site
  belongs_to :user
  belongs_to :state

  attr_accessor :zone_uuid

  validates_presence_of :name, :width, :height
  validates_attachment_content_type :ad, :content_type => [ 'image/png', 'image/jpeg', 'image/gif', 'application/x-shockwave-flash' ]
  validates_attachment_size :ad, :less_than => 1.megabytes       
  validates_attachment_presence :ad

  scope :active, where(:state_id => CONFIG['state_ad_active'])
  scope :belongs_to_user, lambda { |user_id| { :conditions => ['user_id = ?', user_id] } }
  scope :belongs_to_site, lambda { |site_id| { :conditions => ['site_id = ?', site_id] } }

  has_attached_file :ad,
    :url => "/system/ads/:id_partition/:basename.:extension",
    :path => ":rails_root/public/system/ads/:id_partition/:basename.:extension"

  def randomize_file_name
    if self.ad_file_name_changed?
      extension = File.extname(ad_file_name).downcase
      self.ad.instance_write(:file_name, "#{ActiveSupport::SecureRandom.hex(16)}#{extension}")
    end
  end

  def flash_content?
    ad_content_type == "application/x-shockwave-flash"
  end

  private
    def set_state
      self.state_id = CONFIG['state_ad_active']
    end
end
