
require "bundler/capistrano"
require "rvm/capistrano"

set :application, "myproject"
set :repository, "git@github.com:kanimozhiR/OLS.git"

set :scm, :git
set :user, "deploy"
set :use_sudo, false
set :deploy_to, "/var/www/#{application}"
set :deploy_via, :remote_cache

#ssh_options[:use_agent] = false
#ssh_options[:keys] = %w(/var/git/.ssh/bitbucket_rsa)
set :branch, "master"
role :web, "OLS.com"
role :app, "OLS.com"
role :db, "OLS.com", :primary => true


after "deploy", "deploy:bundle_gems" # keep only the last 5 releases
after "deploy:bundle_gems", "deploy:restart" # keep only the last 5 releases

namespace :deploy do
  task :bundle_gems do
run "cd #{deploy_to}/current && bundle install vendor/gems/"
end

task :start do ; end
task :stop do ; end
task :restart, :roles  => :app, :except => {:no_release  => true} do
      run  "touch #{File.join(current_path, 'tmp', restart.txt)}"
  end
end

