ActionController::Routing::Routes.draw do |map|
  map.resources :amenities

  map.resources :parks

  map.root :controller => 'parks', :action => 'index'

  map.resource :session, :controller => 'sessions'
end
