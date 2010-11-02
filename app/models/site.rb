class Site < ActiveRecord::Base
  before_create :set_state

  belongs_to :user
  belongs_to :state

  has_many :zones
  has_many :ads

  accepts_nested_attributes_for :zones

  scope :active, where(:state_id => CONFIG['state_site_active'])
  scope :belongs_to_user, lambda { |user_id| { :conditions => ['user_id = ?', user_id] } }
  # TODO: http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html
  scope :with_zones, :joins => "LEFT JOIN zones ON sites.id = zones.site_id", :select => "sites.name AS site_name, zones.name AS name, zones.id AS id"
  
  validates_presence_of :name, :url
  validates_uniqueness_of :name, :url

  private
    def set_state
      self.state_id = CONFIG['state_site_active']
    end
end