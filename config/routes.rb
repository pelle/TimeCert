Timecert::Application.routes.draw do
  get ':digest.:format' => 'digests#show', :as => :stamp, :digest => /[0123456789abcdef]{40}/
  match 'generate' => 'digests#new', :as => :generate
  match 'digest' => 'digests#create', :as => :digest
  resource :github
  root :to => "welcome#index"
end
