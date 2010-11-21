Timecert::Application.routes.draw do
  get ':digest(.:format)', :to => 'digests#show', :as => :stamp, :digest => /[0123456789abcdef]{40}/
  get 'generate', :to => 'digests#new', :as => :generate
  post 'digest', :to => 'digests#create', :as => :digest
  get "github", :to => "github#show", :as=>:github
  post "github", :to => "github#create", :as=>:github_hook

  get "audit", :to => "audit#index"  
  get "developers", :to => "developers#index"
  get "developers/ruby", :to => "developers#ruby"
  get "developers/python", :to => "developers#python"
  
  root :to => "welcome#index"

  
end
