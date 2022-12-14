Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
                                 sign_in: 'login',
                                 sign_out: 'logout',
                                 registration: 'signup'
                               },
                     controllers: {
                       sessions: 'users/sessions',
                       registrations: 'users/registrations'

                     }
  get '/', to: 'users#index', as: :home
  get '/current_user', to: 'current_user#index'

  namespace :api do
    namespace :v1 do
      resources :posts
    end
  end

  get 'users/:id', to: 'users#show', as: :user
  get 'users/:id/posts', to: 'posts#index', as: :user_posts
  get 'users/:id/posts/new', to: 'posts#new', as: :user_post_new
  get 'users/:id/posts/:post_id', to: 'posts#show', as: :post
  get 'users/:id/posts/:post_id/comment/new', to: 'comments#new', as: :comment
  post 'users/:id/posts/create', to: 'posts#create', as: :posts_create
  post 'users/:id/posts/:post_id/comment/create', to: 'comments#create', as: :comment_create
  post 'users/:id/posts/:post_id/create/like', to: 'likes#create', as: :like_create
  delete 'users/:id/posts/:post_id/delete', to: 'posts#destroy', as: :post_delete
  delete 'users/:id/posts/:post_id/comment/:comment_id/delete', to: 'comments#destroy', as: :comment_delete
end
