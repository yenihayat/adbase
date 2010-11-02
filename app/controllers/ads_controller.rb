class AdsController < ApplicationController
  before_filter :authenticate_user!
  layout 'application'

  def index
    if params[:site_id]
      @ads = Ad.active.belongs_to_site(params[:site_id])
    else
      if current_user.is_admin?
        @ads = Ad.active
      else
        @ads = Ad.active.belongs_to_user(current_user.id)
      end
    end
  end

  def show
    @ad = Ad.find(params[:id])
  end

  def new
    @ad = Ad.new
    @states = State.ads
    @users = User.active
  end

  def create
    @ad = Ad.new(params[:ad])
    set_user_id

    if @ad.save
      set_flash(:ad_created)
      redirect_to ad_path(@ad)
    else
      @users = User.active
      @states = State.ads
      render :new
    end
  end

  def edit
    @ad = Ad.find(params[:id])
    @states = State.ads
    @users = User.active
  end

  def update
    @ad = Ad.find(params[:id])

    if @ad.update_attributes(params[:ad])
      set_flash(:ad_updated)
      redirect_to ad_path(@ad)
    else
      @users = User.active
      @states = State.ads
      render :edit
    end
  end

  private
    def set_user_id
      unless @ad.user_id and current_user.is_admin?
        @ad.user_id = current_user.id
      end
    end
end
