Rails.application.routes.draw do
  devise_for :users
  root "pages#top"

  resource :pages, only:[] do
    collection do
      get :host_entry, :test
    end
  end

  resources :spaces do
    get    '/dashboard', to: 'dashboards#first_space'

    collection do
      get :new_first

    end

    resources :rooms do
      collection do
        get :new_first
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

      resources :amenities, only: [:new,:create, :update]

    end
    resource :settings, only:[] do
      resources :host_profiles, only: [:index, :create,:update]
      resources :host_addresses, only: [:index, :create, :update]
      resources :host_banks, only: [:index,:create, :update]
    end
  end

  resources :users do
    resources :rooms, only: [:index] do
      resources :space_infos, only: [:edit, :update]
      resources :basic_infos, only: [:edit, :update]
      resources :pictures, only: [:edit, :update]
      resources :plans, only: [:edit, :update]
      resources :intros, only: [:edit, :update]
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
        get :host_address
        get :host_bank
        get :calender
        get :admin
        get :notification
      end
    end

  end

  resources :rooms do
    member do
      get :for_wating
    end
  end

end
