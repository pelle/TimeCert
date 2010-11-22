require 'bundler/capistrano'
load 'deploy' if respond_to?(:namespace) # cap2 differentiator

# SSH OPTIONS
ssh_options[:forward_agent] = true
ssh_options[:port] = 11870
ssh_options[:paranoid] = false

set :application, 'timecert'
set :deploy_to, '/u/apps/timecert'
set :user, 'deployer'
set :use_sudo, false 


# GIT HUB
default_run_options[:pty] = true
set :scm, "git"
set :repository,  "git@github.com:pelle/TimeCert.git"
set :branch, "deploy"
set :deploy_via,    :remote_cache
set :repository_cache,    "git-cache"
#set :git_enable_submodules, 1


role :app, "timecert.org"
role :web, "timecert.org"
role :db,  "timecert.org", :primary => true

after   'deploy:restart', 'deploy:cleanup'
after   'deploy:update_code', 'deploy:symlink'

#############################################################
#	Passenger
#############################################################

namespace :deploy do
  desc "Restart Application"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  desc "symlink"
  task :symlink do
    run "ln -nfs #{shared_path}/config/exceptional.yml #{release_path}/config/exceptional.yml" 
    run "mkdir -p #{shared_path}/cache"
    run "ln -s #{shared_path}/cache #{release_path}/tmp/cache" 
  end
end
