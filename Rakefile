# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

namespace :css do
  desc 'Build for CSS'
  task :build do
    unless system 'yarn install && yarn build:purgecss'
      raise 'cssbundling-rails: Command css:build failed, ensure yarn is installed and `yarn build:purgecss` runs without errors'
    end
  end
end

Rails.application.load_tasks
