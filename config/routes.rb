Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :questions, shallow: true do
    resources :answers
  end

  root to: 'questions#index'
end
