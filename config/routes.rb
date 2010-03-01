ActionController::Routing::Routes.draw do |map| 
  map.namespace :admin do |admin|
    admin.resources :products, :collection => { :search => :get, :auto_complete => :post }, :member => { :confirm => :get }
  end    
end