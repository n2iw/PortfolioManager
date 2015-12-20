Rails.application.routes.draw do

  root 'public#index'
  get 'work/:id' => 'public#show', as: :work
  get 'work_process/:id' => 'public#show_process', as: :work_process
  get 'about' => 'public#about'
  get 'contact' => 'public#contact'
  get 'awards' => 'public#awards'

  get 'access/login'
  post 'access/attempt_login'
  get 'access/logout'

  get 'admin' => 'works#statistics'

  get 'edit_about' => 'about_paragraphs#edit'
  patch 'update_about' => 'about_paragraphs#update'

  resources :works do
    #collection do
      #get :statistics
      #get :migrate_hit_counts
    #end
    
    member do
      get :delete
      get :show_process
      patch :update_position
    end

    resources :pictures do
      member do
        get :delete
      end
    end

    resources :process_pictures do
      member do
        get :delete
      end
    end

  end

  get 'manage_awards' => 'works#manage_awards'
  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

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
