Rails.application.routes.draw do
  concern :api_base do
    resources :discount_rules
    get '/storage-fee', to: 'item_prices#storage_fee'
  end

  namespace :v1 do
    concerns :api_base
  end

end
