require "rspec/core/rake_task"
require File.expand_path('../spec/example_app/config/application', __FILE__)

Bundler::GemHelper.install_tasks


Rails.application.load_tasks

task(:default).clear
RSpec::Core::RakeTask.new(:spec)
task :default => :spec
