Rails.application.routes.draw do
  # Instructions for the apo
  get 'static_pages/intructions'
  get 'help' => 'static_pages#help'
  get 'about'=>'static_pages#about'
  # devise configuration
  devise_for :users
  # when user is authenticated
  authenticate :user do
    root to: "static_pages#home"
    get 'home' => 'static_pages#home'
    resources :users, only: [:show, :index, :destroy, :num_of_users]
    resources :offsprings, only: [:new, :create, :destroy]
    resources :rooms, only: [:index]
    resources :assignments, only: [:new, :create, :destroy]
    resources :shifts, only: [:show]
    get 'admin' => 'admin#dashboard'
    get 'offsprings' => 'admin#offsprings'
    get 'users' => 'admin#users'
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
