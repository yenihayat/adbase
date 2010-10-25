class RegistrationsController < ApplicationController
  before_filter :authenticate_user!
  include Devise::Controllers::InternalHelpers

  # GET /resource/sign_up
  def new
    build_resource({})
    render_with_scope :new
  end

  # POST /users/new
  def create
    build_resource

    if resource.save
        set_flash_message :notice, :account_created
        redirect_to users_path
    else
      clean_up_passwords(resource)
      render_with_scope :new
    end
  end

  # GET /users/edit
  def edit
    render_with_scope :edit
  end

  # PUT /resource
  def update
    if resource.update_attributes(params[resource_name])
      set_flash_message :notice, :updated
      sign_in resource_name, resource, :bypass => true
      redirect_to after_update_path_for(resource)
    else
      clean_up_passwords(resource)
      render_with_scope :edit
    end
  end

  # DELETE /resource
  def destroy
    resource.destroy
    sign_out_and_redirect(self.resource)
    set_flash_message :notice, :destroyed
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    expire_session_data_after_sign_in!
    redirect_to new_registration_path(resource_name)
  end

  # protected
  # 
  #   # The path used after sign up. You need to overwrite this method
  #   # in your own RegistrationsController.
  #   def after_sign_up_path_for(resource)
  #     after_sign_in_path_for(resource)
  #   end
  # 
  #   # Overwrite redirect_for_sign_in so it takes uses after_sign_up_path_for.
  #   def redirect_for_sign_in(scope, resource) #:nodoc:
  #     redirect_to stored_location_for(scope) || after_sign_up_path_for(resource)
  #   end
  # 
  #   # The path used after sign up for inactive accounts. You need to overwrite
  #   # this method in your own RegistrationsController.
  #   def after_inactive_sign_up_path_for(resource)
  #     root_path
  #   end
  # 
  #   # The default url to be used after updating a resource. You need to overwrite
  #   # this method in your own RegistrationsController.
  #   def after_update_path_for(resource)
  #     if defined?(super)
  #       ActiveSupport::Deprecation.warn "Defining after_update_path_for in ApplicationController " <<
  #         "is deprecated. Please add a RegistrationsController to your application and define it there."
  #       super
  #     else
  #       after_sign_in_path_for(resource)
  #     end
  #   end
end
