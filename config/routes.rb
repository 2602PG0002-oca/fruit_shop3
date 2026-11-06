Rails.application.routes.draw do
  # ユーザ認証
  devise_for :users

  # マイページ
  resources :mypage, only: [:show]

  # 商品関連
  resources :products

  # 注文関連
  resources :orders, only: [:index, :new, :create] do
    collection do
      post :confirm
    end
    member do
      get :complete
    end
  end

  # カート関連（セッションカート）
  resources :carts, only: [:show, :index] do
    collection do
      post :add_product
    end
    member do
      delete :remove_item
      post :update_quantity
    end
  end

  # ユーザーのカート内の商品操作
  resources :cart_items, only: [:create, :update, :destroy]

  root to: "homes#top"

  get "up" => "rails/health#show", as: :rails_health_check
end