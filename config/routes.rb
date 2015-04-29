Rails.application.routes.draw do
  root 'main#root'

  namespace :manager do
    resources :places do
      resources :reviews
      resources :areas
    end
  end

  namespace :api do
    get '/' => 'main#root'

    post 'auth' => 'authorization#auth'

    get 'places' => 'places#index'

    get 'places/:id' => 'places#show'

    get 'reviews' => 'reviews#index'

    get 'places/:id/reviews' => 'reviews#show'

    post 'places/:id/reviews' => 'reviews#store'

    get 'orders' => 'orders#index'

    post 'orders' => 'orders#store'

    delete 'orders/:id' => 'orders#destroy'
  end

  namespace :admin do

    post 'auth' => 'authorization#attach'

    get 'orders' => 'orders#index'

    # get 'orders/:id' => 'orders#index'

    patch 'orders/:id' => 'orders#update'

    get 'reviews' => 'reviews#index'

    get 'areas' => 'areas#avaiable'

  end
end
