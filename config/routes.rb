Timecert::Application.routes.draw do
  get 'generate', :to => 'digests#new', :as => :generate
  post 'digest', :to => 'digests#create', :as => :digest
  resource :github
  root :to => "welcome#index"
  get ':digest(.:format)', :to => 'digests#show', :as => :stamp, :digest => /[0123456789abcdef]{40}/


end
