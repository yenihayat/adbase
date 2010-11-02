class User < ActiveRecord::Base
  before_create :set_state

  # Include devise modules.
  devise :database_authenticatable, :recoverable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :firstname, :lastname, :company, :phone, :is_admin

  validates_presence_of :firstname, :lastname, :email
  validates_uniqueness_of :email

  scope :active, where(:state_id => CONFIG['state_user_active'])

  def name
    "#{firstname} #{lastname}"
  end

  def info
    "#{firstname} #{lastname} <#{email}>"
  end

  def has_active_site?
    Site.exists?(:user_id => self) or self.is_admin?
  end

  private
    def set_state
      self.state_id = CONFIG['state_user_active']
    end
end
