class ClientsController < ApplicationController
  before_action :authenticate_client!, except: %i[create index]
  def index; end

  def show
    @client = Client.includes(:bank_accounts).find(params[:id])
    @bank_accounts = @client.bank_accounts
  end

  def create
    if client_signed_in?
      redirect_to client_path(current_client)
    else
      @client = Client.new(client_params)
      if @client.save
        redirect_to client_path(current_client)
      else
        render :new
      end
    end
  end

  def destroy
    session[:client_id] = nil
    redirect_to root_url
  end

  def logout
    reset_session
    redirect_to root_url
  end

end
