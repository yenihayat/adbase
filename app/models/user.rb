class User < ActiveRecord::Base
  before_create :set_state

  devise :database_authenticatable, :recoverable, :rememberable, :trackable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :firstname, :lastname, :company, :phone, :is_admin

  validates_presence_of :firstname, :lastname, :email
  validates_uniqueness_of :email

  scope :active, where(:state_id => CONFIG['state_user_active'])

  has_many :sites, :through => :user_sites
  has_many :user_sites

  def name
    "#{firstname} #{lastname}"
  end

  def info
    "#{firstname} #{lastname} <#{email}>"
  end

  def has_active_site?
    UserSite.exists?(:user_id => self) or self.is_admin? # TODO: Check state also.
  end

  private
    def set_state
      self.state_id = CONFIG['state_user_active']
    end
end
