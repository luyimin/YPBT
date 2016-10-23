# frozen_string_literal: true
require 'rake/testtask'

task default: :spec

desc 'run tests'
task :spec do
  sh 'ruby spec/videocommentthreads_spec.rb'
end

desc 'delete cassette fixtures'
task :wipe do
  sh 'rm spec/fixtures/cassettes/*.yml' do |ok, _|
    puts(ok ? 'Cassettes deleted' : 'No casseettes found')
  end
end

desc 'quality checks'
namespace :quality do
  desc 'run all quality checks'
  task all: [:rubocop, :flog, :flay]

  task :rubocop do
    sh 'rubocop'
  end

  task :flog do
    sh 'flog lib/*.rb'
    sh 'flog spec/*.rb'
  end

  task :flay do
    sh 'flay lib/*.rb'
    sh 'flay spec/*.rb'
  end
end
