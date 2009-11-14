ActionController::Routing::Routes.draw do |map|
  map.resources :parks

  map.root :controller => 'parks', :action => 'index'

end
