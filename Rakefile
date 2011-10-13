# encoding: utf-8

require 'rubygems'
require 'bundler'
require "bundler/gem_tasks"

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

$LOAD_PATH.unshift('lib')

require 'rake'
require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.test_files = FileList.new('test/**/*_test.rb') do |list|
    list.exclude 'test/test_helper.rb'
  end
  test.libs << 'test'
  test.verbose = true
end

require 'yard'
YARD::Rake::YardocTask.new do |t|
  t.files   = FileList['lib/**/*.rb']
end

require 'rcov/rcovtask'
Rcov::RcovTask.new(:rcov => :check_dependencies) do |rcov|
  rcov.libs << 'test'
  rcov.pattern = 'test/**/*_test.rb'
end

task :default => :test