Rails.application.routes.draw do
  get 'searches/search'
  get 'relationships/create'
  get 'relationships/destroy'
  get 'book_comments/create'
  get 'book_comments/destroy'
  devise_for :users
  root 'homes#top'
  get 'home/about' => 'homes#about'

  get 'user/search_book', to: 'users#search_book'
  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships,only: [:create, :destroy]
    get 'followings' => 'relationships#followings'
    get 'followers' => 'relationships#followers'
  end

  resources :books do
   resources :book_comments, only: [:create, :destroy]
   resource :favorites,only:[:create,:destroy]
  end
  
  get 'message/:id', to: 'messages#show', as: 'message'
  resources :messages,only:[:create]
  resources :rooms,only:[:create, :show]
  
  resources :groups, except: [:destroy]

end
