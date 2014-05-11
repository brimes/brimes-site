Site2::Application.routes.draw do
  get "home" => "home#index"
  get "site/index"

  
  # Usuários
  match "login" => "usuarios#login", :as => "login", via: [:get, :post]
  match "register" => "usuarios#register", :as => "register", via: [:get, :post]
  get "logout" => "usuarios#logout"
  get "usuarios/profile"
  get "usuarios/confirmacao_cadastro"
  post "usuarios/confirmacao_cadastro"
  match "mudar_senha_ajax" => "usuarios#mudar_senha_ajax", via: [:post]
  
  #API
  post "api/stop"
  post "api/start"
  post "api/contas"
  post "api/beneficiarios"
  post "api/categorias"
  post "api/recorrentes"
  post "api/transacoes"

  post "api/get_contas"
  post "api/get_beneficiarios"
  post "api/get_categorias"
  post "api/get_recorrentes"
  post "api/get_transacoes"
  
  
  resources :usuarios
  resources :sincronizacao

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'site#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
