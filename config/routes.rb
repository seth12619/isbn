Rails.application.routes.draw do
  resources :books do
    post 'search', on: :collection
    get 'isbn_transformer', on: :collection
    get 'get_json_search', on: :collection
  end

  root 'books#index'
end
