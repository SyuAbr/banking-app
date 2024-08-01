# frozen_string_literal: true

module Clients
  class PasswordsController < Devise::PasswordsController
    # GET /resource/password/new
    # def new
    #   super
    # end

    # POST /resource/password
    # def create
    #   super
    # end

    # GET /resource/password/edit?reset_password_token=abcdef
    # def edit
    #   super
    # end

    # PUT /resource/password
    # def update
    #   super
    # end

    # protected

    # def after_resetting_password_path_for(resource)
    #   super(resource)
    # end

    # The path used after sending reset password instructions
    # def after_sending_reset_password_instructions_path_for(resource_name)
    #   super(resource_name)
    # end
    # Ensure that the reset password token is passed in the params
    # protected

    # def assert_reset_token_passed
    #  return if params[:reset_password_token].present?

    #  redirect_to new_client_session_path(resource_name), alert: t('devise.passwords.no_token')
    # end

    # Override the path used after sending reset password instructions
    # def after_sending_reset_password_instructions_path_for(resource_name)
    #  new_client_session_path(resource_name) if is_navigational_format?
    # end

    # Override the path used after resetting password
    # def after_resetting_password_path_for(resource)
    # signed_in_root_path(resource)
    # end
  end
end
