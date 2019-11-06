Rails.application.routes.draw do
  resources :payments
  resources :reservations
  resources :tickets
  resources :events
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'event_info/:id', to: 'features#event_info'
  get 'event_tickets/:id', to: 'features#event_tickets'
end
