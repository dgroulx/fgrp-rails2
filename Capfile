load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }

load 'config/deploy' # remove this line to skip loading any of the default tasks

set :stages, %w(staging production)
require 'capistrano/ext/multistage'

set :default_stage, "staging"

task :uname do
    run "uname -a"
end
