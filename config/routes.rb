Rails.application.routes.draw do
  root 'application#index'

  defaults format: :json do
    get 'dashboard', to: 'application#dashboard'
    post 'countries/visit', to: 'countries#visit'
    post 'sessions', to: 'user/sessions#create'
  end

  get '*path', to: 'application#index'
end
