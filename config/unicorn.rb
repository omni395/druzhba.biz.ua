# set path to the application
app_dir = File.expand_path("../..", __FILE__)
shared_dir = "#{app_dir}/shared"
working_directory app_dir

# Set unicorn options
worker_processes 2
preload_app true
timeout 30

# Path for the Unicorn socket
listen "/home/deploy/druzhba/shared/tmp/sockets/unicorn.sock", :backlog => 64

# Set path for logging
stderr_path "/home/deploy/druzhba/shared/log/unicorn.stderr.log"
stdout_path "/home/deploy/druzhba/shared/log/unicorn.stdout.log"

# Set proccess id path
pid "/home/deploy/druzhba/shared/tmp/pids/unicorn.pid"