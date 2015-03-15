Rails.application.routes.draw do
  root 'main#root'

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
end
