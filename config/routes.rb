ActionController::Routing::Routes.draw do |map|
  map.resources :amenities

  map.resources :parks, :has_many => 'links'

  map.root :controller => 'pages', :action => 'explore'

  map.resource :session, :controller => 'sessions'
  
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
end
