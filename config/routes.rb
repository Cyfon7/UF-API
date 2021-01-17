Rails.application.routes.draw do
  #resources :uf_records
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'uf/:uf_date', to: 'uf_records#request_data'
  get 'uf_records/create'
  get 'client/:client', to: 'uf_records#client'

  get 'client/', to: proc { [404, {}, ["Unathorized access"]] }
  get 'uf/', to: proc { [404, {}, ["You shall not pass"]] }
  root to: proc { [404, {}, ["Sorry, This is an API"]] }
end
