# frozen_string_literal: true

require "bundler/gem_tasks"

desc "Run spec"
task :spec do
  sh "firebase --project test emulators:exec --only firestore 'rspec'"
end

task default: :spec
