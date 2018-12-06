Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'

  get '/current_rate' => 'quotes#current_rate'

  namespace :admin do
    root 'manual_rates#new'
    resources :manual_rates, only: %i[new create]
  end

  mount ActionCable.server => '/cable'
end
