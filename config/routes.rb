CarNextDoor::Application.routes.draw do
  get "cars/index"
  resources :sessions

#get "index_page/index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'sessions#new'
  match '/book',                to: 'reservations#book',         via: 'post'
  match '/reservation/cancel',  to: 'reservations#cancel',       via: 'post'

  match '/reservation/editsubmit',   to: 'reservations#editsubmit',    via: 'post'
  match '/reservation/extendsubmit', to: 'reservations#extendsubmit',  via: 'post'
  match '/reservation/earlysubmit',  to: 'reservations#earlysubmit',   via: 'post'

  match '/reservation',         to: 'reservations#index',        via: 'get'
  match '/reservation/edit',    to: 'reservations#edit',         via: 'get'
  match '/reservation/search',  to: 'reservations#search',       via: 'post'
  match '/reservation/view',    to: 'reservations#view',         via: 'get'
  match '/profile',             to: 'users#profile',             via: 'get'
  match '/new',                 to: 'reservations#new',          via: 'get'
  match '/contact',             to: 'static_pages#contact',      via: 'get'
  match '/signout',             to: 'sessions#destroy',          via: 'delete'
  match '/reservation/extend',  to: 'reservations#extend',       via: 'get'
  match '/reservation/early',   to: 'reservations#early',        via: 'get'
  match '/reservation/confirm', to: 'reservations#confirm',      via: 'get' 
  match '/cars',                to: 'cars#index',                via: 'get'
  match '/cars/reserve',        to: 'cars#reserve',              via: 'get'
  match '/cars/manage',         to: 'cars#manage',               via: 'get' 
  match '/cars/details',        to: 'cars#details',              via: 'get' 
  match '/cars/rates',          to: 'cars#rates',                via: 'get' 
  match '/cars/parking',        to: 'cars#parking',              via: 'get' 
  match '/cars/schedule',       to: 'cars#schedule',             via: 'get' 
  
  match '/messages',             to: 'messages#index',            via: 'get'
  match '/messages/widget',       to: 'messages#widget',           via: 'get'
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
