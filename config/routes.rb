Rails.application.routes.draw do

  get '/', to: "posts#index"

  resources :posts, param: :slug

end
