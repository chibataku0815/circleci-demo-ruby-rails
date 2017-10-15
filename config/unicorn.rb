pid "/tmp/unicorn.pid"

# listen
#if ENV['RACK_ENV'] == 'production' || ENV['RACK_ENV'] == 'staging'
#  listen "/tmp/unicorn.sock", backlog: 512
#else
listen 9292, tcp_nopush: true
#end

# logging
#stderr_path "/var/log/unicorn/unicorn_error.log"
#stdout_path "/var/log/unicorn/unicorn.log"

# workers
if ENV['RACK_ENV'] == 'development'
  worker_processes 1
else
  worker_processes 5
end

# use correct Gemfile on restarts
before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = "#{Dir.pwd}/Gemfile"
end
