Rails.application.routes.draw do
  
  root "projects#dashboard"

  match ':controller(/:action(/:id(/:format)))', :via => [:get, :post, :patch]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
