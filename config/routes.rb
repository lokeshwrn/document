Rails.application.routes.draw do

  root 'home#dashboard'

  get '/get_favourites' => 'home#get_favs'
  get '/get_toppers' => 'home#get_toppers'

  get 'categories' => 'categories#index', :as => :categories
  get 'categories/:id/edit' => 'categories#edit', :as => :edit_category
  get 'categories/new' => 'categories#new', :as => :new_category
  post 'categories/create' => 'categories#create', :as => :create_category
  post 'categories/update' => 'categories#update', :as => :update_category

  get 'categories/:category_id/sub-categories' => 'sub_categories#index', :as => :sub_categories
  get 'categories/:category_id/sub-categories/:id/edit' => 'sub_categories#edit', :as => :edit_sub_category
  get 'categories/:category_id/sub-categories/new' => 'sub_categories#new', :as => :new_sub_category
  post 'categories/:category_id/sub-categories/create' => 'sub_categories#create', :as => :create_sub_category
  post 'categories/:category_id/sub-categories/update' => 'sub_categories#update', :as => :update_sub_category

  get 'sub-categories/:sub_category_id/articles' => 'articles#index', :as => :articles
  get 'sub-categories/:sub_category_id/articles/:id/edit' => 'articles#edit', :as => :edit_article
  get 'sub-categories/:sub_category_id/articles/new' => 'articles#new', :as => :new_article
  post 'sub-categories/:sub_category_id/articles/create' => 'articles#create', :as => :create_article
  post 'sub-categories/:sub_category_id/articles/update' => 'articles#update', :as => :update_article
  get 'sub-categories/:sub_category_id/articles/:id' => 'articles#show', :as => :show_article

  get 'home/dashboard'
  get ':id' => 'home#tiny_url', :article_id => /(\d+)/


  # get 'comments/create'
  #
  # get 'sessions/create'
  #
  # resources :articles, :categories, :sub_categories



  resources :users do
    get 'index'
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
