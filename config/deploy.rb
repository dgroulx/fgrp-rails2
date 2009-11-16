task :production do
  set :user, "friendsofgrparks"
  set :application, "explore.friendsofgrparks.org"
  set :repository,  "ssh://git@gitorious.atomicobject.com:2022/friends-of-grand-rapids-parks/givecamp.git"
  set :branch, "master"
  set :copy_remote_dir, "/home/#{user}"
  role :app, application
  role :web, application
  role :db,  application, :primary => true
  set :deploy_to, "/home/#{user}/#{application}"
end

task :staging do
  set :user, "zgchurch"
  set :application, "friends.churchandsons.com"
  set :repository,  "ssh://git@gitorious.atomicobject.com:2022/friends-of-grand-rapids-parks/givecamp.git"
  set :branch, "master"
  set :copy_remote_dir, "/home/#{user}"
  role :app, application
  role :web, application
  role :db,  application, :primary => true
  set :deploy_to, "/home/#{user}/#{application}"
end

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
 set :use_sudo, false

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion
set :scm, :git
set :deploy_via, :remote_cache


namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
  
  desc "Symlink shared configs and folders on each release."
    task :symlink_shared do
      run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    end
  
  
end

after 'deploy:update_code', 'deploy:symlink_shared'
