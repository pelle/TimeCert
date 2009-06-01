ActionController::Routing::Routes.draw do |map|
  map.stamp ":digest.:format",:controller=>"digests",:action=>"show",:digest=>/[0123456789abcdef]{40}/,:method=>:get
  map.generate "generate",:controller=>"digests",:action=>"new"
  map.digest "digest",:controller=>"digests",:action=>"create"
  map.root :controller => "welcome"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
