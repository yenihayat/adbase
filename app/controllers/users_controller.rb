class UsersController < ApplicationController
  before_filter :authenticate_user!
  layout "application"

  def index
    @users = User.all(:order => "created_at desc")
  end

  def show
  end

  def profile
    @user = current_user
  end

  def new
    @user = User.new
  end

  def edit
    if current_user.is_admin?
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end

  def update
    if current_user.is_admin?
      @user = User.find(params[:id])
    else
      @user = current_user
    end

    if @user.update_attributes(params[:user])
      flash[:notice] = "Profil güncellendi."
      redirect_to edit_user_path(@user)
    else
      render :edit
    end
  end
end
