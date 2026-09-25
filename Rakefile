# frozen_string_literal: true

require "bundler/gem_tasks"

desc "Run spec"
task :spec do
  args = []
  args << "--debug" if ENV["FIREBASE_DEBUG"]
  sh "firebase #{args.join(" ")} --project test emulators:exec --only firestore 'rspec'"
end

desc "Check rbs"
task :rbs do
  sh "rbs validate"
  sh "steep check"
end

desc "Run all"
task all: %i(spec rbs)

task default: :all
