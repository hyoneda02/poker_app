Rails.application.routes.draw do
  # For details on the DSL av"ailable within this file, see http://guides.rubyonrails.org/routing.html
  get "home" => "home#new"
  #PostmanのAPIを作るときのURL接続先
  get "show" => "home#show"
  #webでAPIを作るときのURL接続先　
end
