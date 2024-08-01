Rails.application.routes.draw do
  root 'clients#index'
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :clients, controllers: {
    registrations: 'clients/registrations',
    sessions: 'clients/sessions',
    passwords: 'clients/passwords',
  confirmations: 'clients/confirmations'
  }


  get 'clients/:client_id/bank_accounts/:id/more', to: 'bank_accounts#more', as: 'more_client_bank_account'
  get '/clients/:client_id/bank_accounts/:id/destroy', to: 'bank_accounts#destroy', as: 'destroy_client_bank_account'

  resources :clients do
    resources :bank_accounts do
      collection do
        get :deleted
        get 'restore/:id', to: 'bank_accounts#restore', as: 'restore'

      end
    end
  end

  resources :bank_accounts do
    resources :transactions, only: [:new, :index, :create] do
      collection do
        get 'withdrawal', to: 'transactions#new_withdrawal'
        post 'withdrawal', to: 'transactions#withdrawal'
        get 'filter', to: 'transactions#filter'
        get 'transfer_account', to: 'transactions#transfer_account'

        get 'transfer_phone', to: 'transactions#transfer_phone'
        post 'transfer_account', to: 'transactions#transfer_account'
        post 'transfer_phone', to: 'transactions#transfer_phone'
        post 'transfer_by_account_number', to: 'transactions#transfer_by_account_number'
        post 'transfer_by_phone_number', to: 'transactions#transfer_by_phone_number'
      end
    end
  end

  get "/logout", to: "clients#logout"
end
