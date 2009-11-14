ActionController::Routing::Routes.draw do |map|
  map.resources :amenities

  map.resources :parks, :has_many => 'links'

  map.root :controller => 'parks', :action => 'index'

  map.resource :session, :controller => 'sessions'
end
