Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  get 'welcome/index'
  root 'welcome#index'

  namespace :admin do
    root 'manual_rates#new'
    resources :manual_rates, only: %i[new create]
  end
end
