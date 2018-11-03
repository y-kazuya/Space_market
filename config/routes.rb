Rails.application.routes.draw do
  devise_for :users
  root "pages#top"

  resource :pages, only:[] do
    collection do
      get :host_entry, :test
    end
  end

  resources :owners

  resources :spaces do
    get    '/dashboard', to: 'dashboards#first_space'

    collection do
      get :new_first

    end

    resources :rooms do
      resources :favorites do
        collection do
          get :show
          post :first_create
        end
      end

      collection do
        get :new_first
      end

      member do
        get :cancel_policy
        get :terms
      end
      resources :space_infos, only: [:new, :create, :update] do
        collection do
          get :info_select
          patch  :choise_info
        end
      end
      resources :basic_infos, only: [:new, :edit ,:create, :update]
      resources :pictures, only: [:new, :create, :update]
      resources :plans, only: [:new, :create, :update]
      resources :intros, only: [:new,:create, :update]


    end
    resource :settings, only:[] do

      resources :host_profiles, only: [:index, :create,:update]
      resources :host_addresses, only: [:index, :create, :update]
      resources :host_banks, only: [:index,:create, :update]
    end
  end

  resources :users do
    resources :rooms, only: [:index, :new, :create, :destroy] do
      member do
        get :stats
      end

      collection do
        get :newww
      end

      resources :space_infos, controller: "edit_space_infos",only: [:index, :new, :show, :create, :update, :destroy] do
        member do
          patch :chose
        end
      end
      resource :basic_infos,controller: "edit_basic_infos", only: [:show, :update]
      resource :pictures,controller: "edit_pictures" ,only: [:show,:create,:destroy, :update]
      resources :plans, controller: "edit_plans",only: [:index, :new, :show, :create, :update, :destroy] do
        member do
          patch :public
        end
      end
      resources :options, only: [:index, :new, :show, :create, :update, :destroy] do
        member do
          patch :public
        end
      end
      resource :intros, controller: "edit_intros",only: [:show, :update]
      resource :reserve_phrases, only: [:show, :create, :update]
      resource :agreements, only: [:show, :create, :update]
    end
    resource :dashboard
    resource :calender
    resource :inbox
    resource :achievements, only:[] do
      collection do
        get :summary
        get :ranking
        get :reputation
        get :sales
      end
    end
    resource :settings, only:[] do
      collection do
        get :host_profile
        patch :host_profile_update
        get :host_profile_update

        get :host_address
        patch :host_address_update
        get :host_address_update

        get :host_bank
        patch :host_bank_update
        get :host_bank_update

        get :calender
        resource :admin, only: [:show, :create, :destroy]
        resource :host_notification, only: [:show, :update]
      end
    end

  end

  resources :rooms do
    member do
      get :for_wating
    end
  end
  scope  '/dashboard' do
    resources :favorite_lists
  end

  resource :search do
    collection do
      get :event_type, to: 'search#event_type'
    end
  end

  # space_settings_host_profile GET    /spaces/:space_id/settings/host_profile(.:format)                  host_profile#new
  # space_settings_host_profiles POST   /spaces/:space_id/settings/host_profiles(.:format)                 host_profile#create

end
