Rails.application.routes.draw do
  root 'static_pages#home'

	#Casein routes
	namespace :casein do
		resources :dashboards

		resources :documents do
      collection do
        post :insert_file
        post :edit_multiple
        post :update_multiple
      end
    end
		resources :news_items do
      collection do
        post :edit_multiple
        post :update_multiple
      end
    end
		resources :courseformats do
      collection do
        post :edit_multiple
        post :update_multiple
        post :import
      end
    end
		resources :menus do
      collection do
        post :edit_multiple
        post :update_multiple
      end
    end
		resources :quotes do
      collection do
        post :edit_multiple
        post :update_multiple
        post :import
      end
    end
		resources :fees do
      collection do
        post :edit_multiple
        post :update_multiple
        post :import
      end
    end
		resources :events do
      collection do
        post :edit_multiple
        post :update_multiple
        post :import
      end
    end
		resources :pages do
      collection do
        post :edit_multiple
        post :update_multiple
        post :import
      end
    end
		resources :staffs do
      collection do
        post :edit_multiple
        post :update_multiple
        post :import
      end
    end
		resources :photos do
      collection do
        get :edit_multiple
        post :update_multiple
        # post :imageable_create
      end
    end
		resources :klasses do
      collection do
        post :edit_multiple
        post :update_multiple
        post :import
      end
    end
		resources :courses do
      collection do
        post :edit_multiple
        post :update_multiple
        post :import
      end
    end
	end

  post "casein/versions/:id/revert" => 'casein/versions#revert', :as => "revert_version"
  get 'summer_whats_next', :to => 'static_pages#summer_whats_next'
  get 'mini_whats_next', :to => 'static_pages#mini_whats_next'
  get 'tersm_and_conditions', :to => 'static_pages#terms_and_conditions'
  get 'privacy_policy', :to => 'static_pages#privacy_policy'
  post 'get_calendar', :to => 'static_pages#get_calendar'
  get 'speciality/:speciality', :to => 'staffs#index', as: :speciality

  resources :courseformats, :only => [:index, :show] do
      resource :photos, :only => [:index, :show]
  end

  resources :courses, :only => [:index, :show] do
      resource :photos, :only => [:index, :show]
  end

  resources :staffs, :only => [:index, :show]

  resources :pages, :only => [:index, :show]

  resources :events, :only => [:index, :show]

  resources :news_items, :only => [:index, :show]

  resources :bookings, :only => [:index, :show, :create]


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
