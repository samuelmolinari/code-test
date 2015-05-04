require 'rake'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.libs.push 'spec'
end

namespace :test do
  desc 'Test coverage'
  task :coverage do
    ENV['COVERAGE'] = 'true'
    Rake::Task['test'].execute
  end

  desc 'Test code style'
  task :style do
    sh 'rubocop'
  end

  task all: [:style, :coverage]
end

task(default: :test)
