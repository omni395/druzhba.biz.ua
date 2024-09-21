# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
lock '~> 3.19.1'

set :application, 'druzhba'
set :repo_url, 'https://github.com/omni395/druzhba.biz.ua.git'

# Deploy to the user's home directory
set :deploy_to, "/home/deploy/#{fetch :application}"

append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public/system',
       'public/uploads'

# Only keep the last 2 releases to save disk space
set :keep_releases, 2

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

namespace :deploy do
  before :compile_assets, :run_purgecss

  task :run_purgecss do
    execute "cd #{release_path} && yarn build:purgecss"
  end
end