class ZonesController < ApplicationController
  before_filter :authenticate_user!
  layout 'application'

  def index
  end
end
