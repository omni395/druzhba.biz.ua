# frozen_string_literal: true

# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'
run Rails.application
Rails.application.load_server

# require ::File.expand.path('../config/environment'), __FILE__
# run Rails.application
