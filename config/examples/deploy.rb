# http://github.com/ryanb/railscasts/blob/master/config/deploy.rb

default_run_options[:pty] = true

set :application, "domain.com"
role :app, application
role :web, application
role :db,  application, :primary => true

set :user, "deployer"
set :deploy_to, "/var/www/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:yenihayat/adbase.git"
set :branch, "master"

namespace :deploy do
  desc "Tell Passenger to restart."
  task :restart, :roles => :web do
    run "touch #{deploy_to}/current/tmp/restart.txt" 
  end

  desc "Do nothing on startup so we don't get a script/spin error."
  task :start do
    puts "You may need to restart Apache."
  end

  desc "Symlink configs."
  task :symlink_configs do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/deploy.rb #{release_path}/config/deploy.rb"
  end

  # http://github.com/javan/whenever
  desc "Update the crontab file"
  task :update_crontab, :roles => :db do
    run "cd #{release_path} && whenever --update-crontab #{application}"
  end
end

after "deploy", "deploy:cleanup"
after "deploy:update_code", "deploy:symlink_configs"
after "deploy:symlink", "deploy:update_crontab"