class User < ActiveRecord::Base
  STATE_ACTIVE = 1
  STATE_PASSIVE = 2

  before_create :set_state

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :firstname, :lastname, :company, :phone, :is_admin

  validates_presence_of :firstname, :lastname, :email
  validates_uniqueness_of :email

  scope :active, where(:state_id => STATE_ACTIVE)

  def name
    "#{firstname} #{lastname}"
  end

  def info
    "#{firstname} #{lastname} <#{email}>"
  end

  private
    def set_state
      self.state_id = STATE_ACTIVE
    end
end
