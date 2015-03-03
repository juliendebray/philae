Rails.application.routes.draw do

  resources :sitemap, only: [:index]


  ActiveAdmin.routes(self)



  get 'connections/new'
  post '/trips/:trip_id/trip_experiences/create_with_new_experience', to: 'trip_experiences#create_with_new_experience', as: 'experience_within_trip'
  post '/trip_comments/:trip_comment_id/trip_experience/create_with_new_experience', to: 'trip_experiences#create_with_comment', as: 'experience_from_comment'
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  get 'experiences/:experience_id/detail', to: 'experiences#detail', as: 'experience_detail'

  scope '(:locale)', locale: /fr|en/ do
    root 'home#index'

    resources :providers, only: [:index, :show]

    resources :experiences, except: [:index] do
      resources :experience_reviews, only: [:new, :create]
    end

    resources :friends, only: [:index] do
      collection do
        post :fb_friends
      end
    end

    resources :users, only: [:show] do
      resources :relationships, only: [:create, :update, :destroy]
    end

    resources :story, only: [:index]
    resources :destinations, only: [:index]
    resources :trips, only: [:update, :show, :create, :orders, :destroy] do
      resources :ask_your_friends, only: [:index]
      member do
        get :start
        get :providers
        get :summarize
        post :update_order
        get ':token' => "trips#show_guest_user", as: :guest_trip
        patch 'share' => "trips#share_trip_email"
        patch 'summarize' => "trips#send_my_trip_email"
        patch 'notif' => "trips#notification_for_sharing_email"
      end
      resources :trip_experiences, only: [:create, :destroy, :update] do
        collection do
          get :markers
          get :trip_markers
        end
      end
      resources :trip_comments, only: [:create, :destroy] do
        collection do
          get :comments_markers
        end
      end
    end
    resources :contacts, only: [:new, :create]
  end
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

