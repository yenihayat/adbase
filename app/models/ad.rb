class Ad < ActiveRecord::Base
  STATE_ACTIVE = 9
  STATE_ARCHIVE = 10
  STATE_PUBLISHED = 7
  STATE_EXPIRED = 8

  before_create :randomize_file_name, :set_state

  has_many :zones, :through => :zone_ads
  has_many :zone_ads

  belongs_to :site
  belongs_to :user
  belongs_to :state

  validates_presence_of :name, :width, :height, :target_url
  # TODO: validates_attachment_content_type, validates_attachment_size.
  validates_attachment_presence :ad

  scope :active, where(:state_id => STATE_ACTIVE)
  scope :belongs_to_user, lambda { |user_id| { :conditions => ['user_id = ?', user_id] } }
  scope :belongs_to_site, lambda { |site_id| { :conditions => ['site_id = ?', site_id] } }

  has_attached_file :ad,
    :url => "/system/ads/:id_partition/:basename.:extension",
    :path => ":rails_root/public/system/ads/:id_partition/:basename.:extension"

  private
    def randomize_file_name
      extension = File.extname(ad_file_name).downcase
      self.ad.instance_write(:file_name, "#{ActiveSupport::SecureRandom.hex(16)}#{extension}")
    end

    def set_state
      self.state_id = STATE_ACTIVE
    end
end
