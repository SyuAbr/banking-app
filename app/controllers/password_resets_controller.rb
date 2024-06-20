class PasswordResetsController < ApplicationController
  def new; end

  def edit
    @client = Client.find_by(reset_password_token: params[:token])
    return if @client.present? && @client.reset_password_token_sent_at > 2.hours.ago

    redirect_to new_client_session_path(@client)
  end

  def create
    @client = Client.find_by(email: params[:email])
    if @client.present?
      @client.set_password_reset_token
      PasswordResetMailer.with(client: @client).reset_email.deliver_later
    end
    redirect_to new_client_session_path(@client)
  end

  def update
    @client = Client.find_by(reset_password_token: params[:client][:reset_password_token])
    if @client.update(client_params)
      @client.update(reset_password_token: nil, reset_password_token_sent_at: nil)
      redirect_to new_client_session_path(@client)
    else
      render :edit
    end
  end

  private

  def client_params
    params.require(:client).permit(:password, :password_confirmation)
  end
end
