# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
lock '~> 3.19.1'

set :application, 'druzhba'
set :repo_url, 'https://github.com/omni395/druzhba.biz.ua.git'

# Deploy to the user's home directory
set :deploy_to, "/home/deploy/#{fetch :application}"

append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public/system',
       'public/uploads'

# Only keep the last 5 releases to save disk space
set :keep_releases, 3

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

#-----------#

#set :unicorn_pid, '/home/deploy/druzhba/shared/tmp/pids/unicorn.pid'
#set :unicorn_bind, '/home/deploy/druzhba/shared/tmp/sockets/unicorn.sock'

#namespace :deploy do
#  before :compile_assets, :run_purgecss

#  task :run_purgecss do
#    run "cd #{release_path} && yarn build:purgecss"
#  end
#end

namespace :deploy do
  before :compile_assets, :run_purgecss

  task :run_purgecss do
    on roles(:app) do
      within release_path do
        execute :yarn, "build:purgecss"
      end
    end
  end
end