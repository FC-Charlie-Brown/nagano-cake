Rails.application.routes.draw do


  #devise_for :admins
  #devise_for :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :customers, skip: :all
  devise_scope :customer do
    post '/customers' => 'public/registrations#create', as: :customer_registration
    get 'customers/sign_up' => 'public/registrations#new', as: :new_customer_registration
    get 'customers/sign_in' => 'public/sessions#new', as: :new_customer_session
    post 'customers/sign_in' => 'public/sessions#create', as: :customer_session
    delete 'customers/sign_out' => 'public/sessions#destroy', as: :destroy_customer_session
  end

  devise_for :admin, skip: :all
  devise_scope :admin do
    get 'admin/sign_in' => 'admin/sessions#new', as: :new_admin_session
    post 'admin/sign_in' => 'admin/sessions#create', as: :admin_session
    delete 'admin/sign_out' => 'admin/sessions#destroy', as: :destroy_admin_session
  end


    get '/', to: 'homes#top', as: 'top'
    get '/about', to: 'homes#about', as: 'about'


    resource :customers, module: 'public', only: [:edit, :update]
    patch '/customers/unsubscribe', to: 'public/customers#withdraw', as: 'withdraw'
    get '/customers/unsubscribe', to: 'public/customers#unsubscribe', as: 'unsubscribe'
    get '/customers/my_page', to: 'public/customers#show', as: 'my_page'

    get '/orders/confirm', to: 'public/orders#confirm', as: 'confirm'
    post '/orders/complete', to: 'public/orders#complete', as: 'complete'
    resources :orders, module: 'public', only: [:index, :show, :create, :new]
  
    resources :items, module: 'public', only: [:index, :show]

    resources :addresses, module: 'public', except: [:new, :show]

    delete '/cart_items/destroy_all', to: 'public/cart_items#destroy_all', as: 'destroy_all'
    resources :cart_items, module: 'public', only: [:index, :update, :create, :destroy]



    namespace :admin do
      resources :customers, only: [:edit, :index, :show, :update]

      resources :orders, only: [:update, :show]

      resources :items, except: [:destroy]

      resources :genres, only: [:edit, :create, :index, :update]

      patch '/order_details', to: 'order_details#update', as: 'order_details'
      get '/', to: 'homes#top', as: 'top'
    end

end
