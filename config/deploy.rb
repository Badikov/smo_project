# set :application, "smo_project"
# set :repository,  "alex@github.com/Badikov/smo_project.git"
# set :branch, "origin/master"
# 
# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# # Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
# 
# # role :web, "your web-server here"                          # Your HTTP server, Apache/etc
# # role :app, "your app-server here"                          # This may be the same as your `Web` server
# # role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
# # role :db,  "your slave db-server here"
# server "217.116.153.106", :app, :web, :db, :primary => true
# # if you want to clean up old releases on each deploy uncomment this:
# # after "deploy:restart", "deploy:cleanup"
# 
# # if you're still using the script/reaper helper you will need
# # these http://github.com/rails/irs_process_scripts
# 
# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
#33333333333333 копирование файлов по SSH
# scp ~/.ssh/id_rsa.pub deployer@server:~/.ssh/authorized_keys
#3333333333333333333333
# RVM bootstrap
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
# require 'rvm/capistrano'
set :rvm_ruby_string, 'ruby 1.9.3p286'
set :rvm_type, :system
set :bundle_cmd, 'source /home/alex/.rvm/scripts/rvm'

# bundler bootstrap
require 'bundler/capistrano'
# main details
set :application, "smo_project"
role :web, "217.116.153.106"
role :app, "217.116.153.106"
role :db,  "217.116.153.106", :primary => true
# server details
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :deploy_to, "/home/alex/smo_project"
set :deploy_via, :remote_cache
set :user, "alex"
set :password, "123108"
set :use_sudo, false
# repo details
set :scm, :git
set :scm_username, "alex"
set :repository, "git://github.com/Badikov/smo_project.git"
set :branch, "master"
# set :git_enable_submodules, 1
# tasks
    namespace :deploy do  
      task :start, :roles => :app do  
      end  
        task :stop, :roles => :app do  
	end  task :restart, :roles => :app do    
	  run "touch #{release_path}/tmp/restart.txt"  
	end  
	task :after_update_code, :roles => :app do    
	  run "rm -rf #{release_path}/public/.htaccess"  
	  end
    end  
# namespace :deploy do
#   task :start, :roles => :app do
#     run "touch #{current_release}/tmp/restart.txt"
#   end
# 
#   task :stop, :roles => :app do
#     # Do nothing.
#   end
# 
#   desc "Restart Application"
#   task :restart, :roles => :app do
#     run "touch #{current_release}/tmp/restart.txt"
#   end
# 
#   desc "Symlink shared resources on each release - not used"
#   task :symlink_shared, :roles => :app do
# #     run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
#   end
# end

after 'deploy:update_code', 'deploy:symlink_shared'

