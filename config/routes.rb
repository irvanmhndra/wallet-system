Rails.application.routes.draw do
  # Wallets
  get "/wallet", to: "wallets#show"

  # Transactions
  resources :transactions, only: [ :index, :create ]

  # Auth Routes
  post "/sign_up", to: "users#sign_up"
  post "/sign_in", to: "users#sign_in"
  delete "/sign_out", to: "users#sign_out"
end
