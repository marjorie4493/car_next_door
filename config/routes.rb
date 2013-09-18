CarNextDoor::Application.routes.draw do
  resources :sessions

#get "index_page/index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'sessions#new'
  match '/reservation',         to: 'reservations#index',           via: 'get'
  match '/reservation/edit',         to: 'reservations#edit',           via: 'get'
  match '/reservation/view',    to: 'reservations#view',            via: 'get'
  match '/profile',             to: 'users#profile',                via: 'get'
  match '/myCar',               to: 'reservations#myCar',           via: 'get'
  match '/manageReservations',  to: 'reservations#manageReservations',  via: 'get'
  match '/new',                 to: 'reservations#new',             via: 'get'
  match '/contact',             to: 'static_pages#contact',         via: 'get'
  match '/signout',             to: 'sessions#destroy',             via: 'delete'
  match '/reservation/edit',    to: 'reservations#edit',           via: 'get'
  match '/reservation/extend',  to: 'reservations#extend',          via: 'get'
  match '/reservation/early',  to: 'reservations#early',          via: 'get'
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
