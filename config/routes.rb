Rails.application.routes.draw do

  root "pages#top"
  devise_for :users


  resource :pages do
    collection do
      get :host_entry, :test
    end
  end

  resources :spaces do
    resources :rooms do
      resources :space_infos, only: [:new, :edit, :create, :update]
      resources :basic_infos, only: [:new, :edit, :create, :update]
      resources :pictures, only: [:new, :edit, :create, :update]
      resources :plans, only: [:new, :edit, :create, :update]
      resources :intros, only: [:new, :edit, :create, :update]
      collection do
        get :new_first
      end
    end
    get    '/dashboard', to: 'dashboard#first_space'
    collection do
      get :new_first
    end
  end


  #room作成からのそれの親スペース作成？
  #一つ目のroomは完成するまで同一レコードを使う（最初new→その後edit

end
