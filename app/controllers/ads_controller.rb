class AdsController < ApplicationController
  before_filter :authenticate_user!
  layout 'application'

  def index
    @ads = Ad.all
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end
end
