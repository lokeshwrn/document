Rails.application.routes.draw do

  get 'tags/index'

  get 'home/dashboard' => 'home#dashboard'
  root 'home#dashboard'

  get '/get_favourites' => 'home#get_favs'
  get '/get_toppers' => 'home#get_toppers'
  post '/get_search' => 'home#get_search'

  # #  CATEGORIES ROUTES
  get '/categories/:id' => 'categories#show', :as => :show_category, :id=>/\d+/

  post '/categories/create' => 'categories#create', :as => :create_category
  post '/categories/update' => 'categories#update', :as => :update_category


  # #  SUB CATEGORIES ROUTES
  get '/sub-categories/:id' => 'sub_categories#show', :as => :show_sub_category, :id=>/\d+/

  post '/sub-categories/create' => 'sub_categories#create', :as => :create_sub_category
  post '/sub-categories/update' => 'sub_categories#update', :as => :update_sub_category


  # #  ARTICLE ROUTES
  get '/articles/:id' => 'articles#show', :as => :show_article, :id=>/\d+/

  post '/articles/create' => 'articles#create', :as => :create_article
  post '/articles/update' => 'articles#update', :as => :update_article


  # #  TAGS ROUTES
  get '/tags/:id' => 'tags#show', :as => :show_tag, :id=>/\d+/

  post '/tags/create' => 'tags#create', :as => :create_tag
  post '/tags/update' => 'tags#update', :as => :update_tag

  resources :articles, :categories, :sub_categories, :tags


  get ':id' => 'home#tiny_url', :article_id => /\d+/, :as => :tiny_url


  # get 'comments/create'
  #
  # get 'sessions/create'
  #

  # resources :users do
  #   get 'index'
  # end

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
