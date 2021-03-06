Store::Application.routes.draw do
  
  scope '(:locale)' do
  
    resources :contacts, only: [:index, :show, :new, :create, :destroy]


    controller :sessions do
      get 'login' => :new
      post 'login' => :create 
      get 'logout' => :destroy
    end

    #get "admin/index"
  
    root :to => "static_pages#home"
 
    get 'clear_brand' => 'products#clear_brand', as: 'clear_brand'
    get 'clear_search' => 'products#clear_search', as: 'clear_search'
    get 'clear_tag' => 'products#clear_tag', as: 'clear_tag'
    #get 'tag_filter/:tag' => 'products#index', as: 'tag_filter'
    get 'products/promotion' => 'products#promotion'
    resources :products
 
    get 'brands/:id/add_filter' => 'brands#add_filter', as: 'add_filter_brands'
    get 'brands/:id/remove_filter' => 'brands#remove_filter', as: 'remove_filter_brands'
    get 'brands/remove_all_filters' => 'brands#remove_all_filters', as: 'remove_all_filters_brands'
    resources :brands

    resources :users

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
