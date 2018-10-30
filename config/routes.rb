Rails.application.routes.draw do
  devise_for :users
  root "pages#top"

  resource :pages do
    collection do
      get :host_entry, :test
    end
  end

  resources :spaces do
    get    '/dashboard', to: 'dashboard#first_space'

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

    resource :settings do
      resources :host_profiles, only: [:index, :create,:update]
      resources :host_addresses, only: [:index, :create, :update]
      resources :host_banks, only: [:index,:create, :update]
    end
  end

  scope  '/dashboard' do
    resources :favorite_lists
  end
  # space_settings_host_profile GET    /spaces/:space_id/settings/host_profile(.:format)                  host_profile#new
  # space_settings_host_profiles POST   /spaces/:space_id/settings/host_profiles(.:format)                 host_profile#create

end
