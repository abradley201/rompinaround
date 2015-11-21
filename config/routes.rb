Rails.application.routes.draw do

  root 'info_stats#new'

  get "board1" => "board1#go1"

  get "go1" => "board1#go1"

  get 'login' => 'info_stats#login'

  get 'logout' => 'info_stats#logout'

  get 'ANF' => 'info_stats#new'

  get 'BAN' => 'info_stats#new'

  get 'PNM' => 'info_stats#new'

  get 'info_stats' => 'info_stats#new'

  post 'login' => 'info_stats#login'

  post 'makematch' => 'duelmatcher#makematch'

  get 'pacemaker' => 'board1#pacemaker'

  post 'command' => 'board1#command'

  get 'cancelsearch' => 'duelmatcher#cancelsearch'


  resources :info_stats

  # get URL => controller#action
  # get index.html/URL => controllername_controller.rb, which has def new method inside

  

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
