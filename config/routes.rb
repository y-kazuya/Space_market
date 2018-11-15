Rails.application.routes.draw do
  devise_for :users
  root "pages#top"

  ##ユーザーが見るだけのページ#################
  resource :pages, only:[] do
    collection do
      get :host_entry, :test
    end
  end
  ####################3

  ##
  resources :owners, only: [:show]


  resources :reservations, only: [:destroy] do
    member do
      get :result
      delete :destroy_reservation
    end

    collection do
      get :confirm_reservation
    end

  end

  resources :spaces do
    get    '/dashboard', to: 'dashboards#first_space'

    collection do
      get :new_first

    end

    resources :rooms do
      resource :reservations do
        member do
          get :preview
        end
      end
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
###オーナーの全体的なルート##########################
  resources :users do
    resources :rooms, only: [:index, :new, :create, :destroy] do
      member do
        get :stats
        patch :public
      end

      collection do
        get :newww
      end
      #########ルームedit#########################3####
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
    #################################33
    ######オーナーダッシュボード#################
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
    ###############################
    #######オーナー設定#################
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
    ####################################
  end
  ##############33333#

  resources :rooms do
    member do
      get :for_wating
    end
  end
  ##user 設定#############################
  scope  '/dashboard' do
    resources :favorite_lists
    scope "/settings" do
      resource :contact, only: [:show, :create, :update]
      resource :account, only: [:show, :update]
      resource :notification, only: [:show, :update]
      resource :payments, only: [:show,:new, :create, :update, :destroy] do
        member do
          get :set_use
        end
      end
    end
  end
  ##################################
  ##検索######################
  resource :search do
    collection do
      get :event_type, to: 'search#event_type'
      get :index, controller: 'search'
    end
  end


  resources :events do
    collection do
      get :plan
    end
  end

  # space_settings_host_profile GET    /spaces/:space_id/settings/host_profile(.:format)                  host_profile#new
  # space_settings_host_profiles POST   /spaces/:space_id/settings/host_profiles(.:format)                 host_profile#create

end
