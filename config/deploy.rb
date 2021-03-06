
#33333333333333 копирование файлов по SSH
# scp ~/.ssh/id_rsa.pub deployer@server:~/.ssh/authorized_keys
#3333333333333333333333
# RVM bootstrap
# $:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'rvm/capistrano'
set :rvm_ruby_string, 'ruby-1.9.3-p392'
set :rvm_type, :user
# set :bundle_cmd, 'source /home/deployer/.rvm/gems/ruby-1.9.3-p286@rails3tutorial/bin/bundle'

# bundler bootstrap
require 'bundler/capistrano'
set :bundle_without, [:development, :test]
# main details
set :application, "smo_project"
set :user, "master"
role :web, "217.116.153.106"
role :app, "217.116.153.106"
role :db,  "217.116.153.106", :primary => true

# server details
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :deploy_to, "/home/#{user}/webapps/#{application}"
set :deploy_via, :remote_cache


set :use_sudo, false
# repo details
set :scm, :git
set :scm_username, "alex"
set :repository, "git://github.com/Badikov/smo_project.git"
set :branch, "master"
set :keep_releases, 3
# set :git_enable_submodules, 1

namespace :deploy do 
#   namespace :assets do
#      task :precompile, :roles => :web, :except => { :no_release => true } do
#           from = source.next_revision(current_revision)
#           if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
#             run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
#           else
#             logger.info "Skipping asset pre-compilation because there were no asset changes"
#           end
#       end
#   end
    
  desc "Start server"
  task :start, :roles => :app do 
    run "#{try_sudo} touch #{File.join(release_path,'tmp','restart.txt')}"
  end
  
  task :stop, :roles => :app do 
    
  end 
  
  desc "Restart server"
  task :restart, :roles => :app do    
    run "#{try_sudo} touch #{File.join(release_path,'tmp','restart.txt')}" 
  end
  
  desc "Symlink shared configs and folders on each release."
  task :symlink_shared, :roles => :app do
    run "ln -nfs #{shared_path}/cached-copy/config/database.yml #{release_path}/config/database.yml"
    #run "ln -nfs #{shared_path}/assets #{release_path}/public/assets"
  end
  
  desc "Execute migrations"
  task :migrate, :roles => :db do
    run "bundle exec rake db:migrate"
  end
end  

after 'deploy:update_code', 'deploy:symlink_shared', 'deploy:cleanup'

