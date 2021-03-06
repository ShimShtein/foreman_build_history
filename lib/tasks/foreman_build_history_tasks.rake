# Tests
namespace :test do
  desc 'Test ForemanBuildHistory'
  Rake::TestTask.new(:foreman_build_history) do |t|
    test_dir = File.join(File.dirname(__FILE__), '../..', 'test')
    t.libs << ['test', test_dir]
    t.pattern = "#{test_dir}/**/*_test.rb"
    t.verbose = true
    t.warning = false
  end
end

namespace :foreman_build_history do
  task :rubocop do
    begin
      require 'rubocop/rake_task'
      RuboCop::RakeTask.new(:rubocop_foreman_build_history) do |task|
        task.patterns = ["#{ForemanBuildHistory::Engine.root}/app/**/*.rb",
                         "#{ForemanBuildHistory::Engine.root}/lib/**/*.rb",
                         "#{ForemanBuildHistory::Engine.root}/test/**/*.rb"]
      end
    rescue
      puts 'Rubocop not loaded.'
    end

    Rake::Task['rubocop_foreman_build_history'].invoke
  end
end

Rake::Task[:test].enhance ['test:foreman_build_history']

load 'tasks/jenkins.rake'
if Rake::Task.task_defined?(:'jenkins:unit')
  Rake::Task['jenkins:unit'].enhance ['test:foreman_build_history', 'foreman_build_history:rubocop']
end
