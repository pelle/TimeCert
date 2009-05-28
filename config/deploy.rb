load 'deploy' if respond_to?(:namespace) # cap2 differentiator

# SSH OPTIONS
#ssh_options[:paranoid] = false
#set :ssh_options, { :forward_agent => true }
ssh_options[:forward_agent] = true
#ssh_options[:port] = 11870
ssh_options[:paranoid] = false

set :application, 'timecert'
set :deploy_to, '/u/apps/timecert'
set :user, 'deployer'
set :use_sudo, false 


# GIT HUB
default_run_options[:pty] = true
set :scm, "git"
set :repository,  "git@github.com:pelle/timecert.git"
set :branch, "deploy"
set :deploy_via,    :remote_cache
set :repository_cache,    "git-cache"
#set :git_enable_submodules, 1


role :app, "timecert.org"
role :web, "timecert.org"
role :db,  "timecert.org", :primary => true

after   'deploy:restart', 'deploy:cleanup'
after   'deploy:update_code', 'rake:gems_install'

#############################################################
#	Passenger
#############################################################

namespace :deploy do
  desc "Restart Application"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end

end

namespace :rake do
  desc "Show the available rake tasks."
  task :show_tasks do
    run("cd #{deploy_to}/current; /usr/bin/rake -T")
  end
  task :gems_install do
    sudo do
      run("cd #{deploy_to}/current; /usr/bin/rake gems:install")
    end
  end
  task :db_create do
    run("cd #{deploy_to}/current; /usr/bin/rake db:create RAILS_ENV=production")
  end
  task :db_schema_load do
    run("cd #{deploy_to}/current; /usr/bin/rake db:schema:load RAILS_ENV=production")
  end
  task :db_restore_database do
    run("cd #{deploy_to}/current; /usr/bin/rake db:s3:restore RAILS_ENV=production")
  end
  task :db_migrate do
    run("cd #{deploy_to}/current; /usr/bin/rake db:migrate RAILS_ENV=production")
  end
end

namespace :memcache do
  desc "Clear Memcached"
  task :clear do
    run "cd #{deploy_to}/current; RAILS_ENV=production script/runner 'Rails.cache.clear'"      
  end
end