require "whenever/capistrano"
require "bundler/capistrano"

set :application, "refuge"
set :repository,  "git@github.com:la-cordee/refuge.git"
set :keep_releases, 2
set :deploy_to, "/home/refuge"
set :use_sudo, false
set :user, "refuge"
set :scm, 'git'
set :default_stage, 'production'
set :branch, fetch(:branch, "master")
set :normalize_asset_timestamps, false
set :ssh_options, {:forward_agent => true}

role :web, "ns382592.ovh.net"
role :app, "ns382592.ovh.net"
role :db,  "ns382592.ovh.net", :primary => true 

default_environment["PATH"] = "$PATH:/opt/ree/bin/"

namespace :deploy do
  task :start do ; end
  task :stop do ; end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :symlink_shared do
    #run "ln -s #{shared_path}/.bundle #{release_path}/.bundle"
    run "ln -s #{shared_path}/config/database.yml #{release_path}/config/"
    run "rm -rf #{release_path}/medias && ln -s #{shared_path}/medias #{release_path}/medias"
    run "rm -rf #{release_path}/public/images && ln -s #{shared_path}/public/images #{release_path}/images"
    run "cp -r #{release_path}/public/javascripts #{shared_path}/public && rm -rf #{release_path}/public && ln -s #{shared_path}/public #{release_path}/public"
    run "rm -rf #{release_path}/vendor && ln -s #{shared_path}/vendor #{release_path}/vendor"
  end

  task :precompile_assets do
    run "cd #{release_path}; export PATH=/opt/ree/bin:$PATH"
    run "cd #{release_path}; export PATH=/opt/ree/lib/ruby/gems/1.8/gems:$PATH"
    run "cd #{release_path}; bundle install"
    run "cd #{release_path}; rake assets:precompile RAILS_ENV=production"
  end

end

namespace :dragonfly do
  desc "Symlink the Rack::Cache files"
  task :symlink, :roles => [:app] do
    run "mkdir -p #{shared_path}/tmp/dragonfly && ln -nfs #{shared_path}/tmp/dragonfly #{release_path}/tmp/dragonfly"
  end
end

after  'deploy:update_code', 'deploy:symlink_shared'
after  'deploy:update_code', 'dragonfly:symlink'
after  'deploy:update_code', 'deploy:precompile_assets'
before 'deploy:restart',     'deploy:migrate'
after  'deploy:restart',     'deploy:cleanup'

