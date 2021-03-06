class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_admin, :except => [:profile, :update]

  layout "application"

  def index
    @users = User.all(:order => "created_at desc")
  end

  def show
    @user = User.find(params[:id])
  end

  def profile
    @user = current_user
  end

  def new
    @user = User.new
    @states = State.users
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      set_flash(:user_created)
      redirect_to edit_user_path(@user)
    else
      @states = State.users
      render :new
    end
  end

  def edit
    if current_user.is_admin?
      @user = User.find(params[:id])
      @states = State.users
    else
      @user = current_user
    end
  end

  def update
    if current_user.is_admin?
      @user = User.find(params[:id])
      @states = State.users
    else
      @user = current_user
    end

    if @user.update_attributes(params[:user])
      set_flash(:profile_updated)
      redirect_to edit_user_path(@user)
    else
      render :edit
    end
  end
end
