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
      resources :basic_infos, only: [:new,:create, :update]
      resources :pictures, only: [:new, :create, :update]
      resources :plans, only: [:new, :create, :update]
      resources :intros, only: [:new,:create, :update]
      resources :favorite, only: [:create, :destory]
    end
  end


  #room作成からのそれの親スペース作成？
  #一つ目のroomは完成するまで同一レコードを使う（最初new→その後edit

end
