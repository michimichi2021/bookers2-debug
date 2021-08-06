Rails.application.routes.draw do
  get 'searches/search'
  get 'relationships/create'
  get 'relationships/destroy'
  get 'book_comments/create'
  get 'book_comments/destroy'
  devise_for :users
  root 'homes#top'
  get 'home/about' => 'homes#about'

  get 'user/book_count', to: 'users#book_count'
  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships,only: [:create, :destroy]
    get 'followings' => 'relationships#followings'
    get 'followers' => 'relationships#followers'
  end

  get "search_book" => "books#search_book"
  get 'book/evaluation_rank' => 'books#evaluation_rank'
  get 'book/new_rank' => 'books#new_rank'
  resources :books do
   resources :book_comments, only: [:create, :destroy]
   resource :favorites,only:[:create,:destroy]
  end
  
  get 'message/:id', to: 'messages#show', as: 'message'
  resources :messages,only:[:create]
  resources :rooms,only:[:create, :show]
  
  resources :groups do      #ここ！
    get "join" => "groups#join"
    get "new/mail" => "groups#new_mail"
    get "send/mail" => "groups#send_mail"
  end

end
