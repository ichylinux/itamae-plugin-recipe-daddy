include_recipe 'daddy::nginx::stop' unless ENV['DOCKER']
include_recipe 'daddy::nginx::install'
include_recipe 'daddy::nginx::start' unless ENV['DOCKER']
