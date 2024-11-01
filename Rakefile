require File.expand_path("../spec/example_app/config/application", __FILE__)

Bundler::GemHelper.install_tasks

Rails.application.load_tasks

task(:default).clear
task default: [:spec]

if defined? RSpec
  task(:spec).clear
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.verbose = false
  end
end

task default: :spec
