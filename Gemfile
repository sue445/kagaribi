# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in kagaribi.gemspec
gemspec

if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("3.1.0")
  # FIXME: workaround for following error at Ruby 3.0
  #        c.f. https://github.com/sue445/kagaribi/actions/runs/17034825111/job/48284793136?pr=49
  #
  # NoMethodError:
  #   undefined method `escapeURIComponent' for CGI:Class
  #   Did you mean?  escapeElement
  # # ./vendor/bundle/ruby/3.0.0/gems/google-cloud-firestore-3.1.0/lib/google/cloud/firestore/service.rb:56:in `block in firestore'
  # # ./vendor/bundle/ruby/3.0.0/gems/google-cloud-firestore-v1-2.0.1/lib/google/cloud/firestore/v1/firestore/client.rb:218:in `initialize'
  # # ./vendor/bundle/ruby/3.0.0/gems/google-cloud-firestore-3.1.0/lib/google/cloud/firestore/service.rb:50:in `new'
  # # ./vendor/bundle/ruby/3.0.0/gems/google-cloud-firestore-3.1.0/lib/google/cloud/firestore/service.rb:50:in `firestore'
  # # ./vendor/bundle/ruby/3.0.0/gems/google-cloud-firestore-3.1.0/lib/google/cloud/firestore/service.rb:187:in `commit'
  # # ./vendor/bundle/ruby/3.0.0/gems/google-cloud-firestore-3.1.0/lib/google/cloud/firestore/batch.rb:402:in `commit'
  # # ./vendor/bundle/ruby/3.0.0/gems/google-cloud-firestore-3.1.0/lib/google/cloud/firestore/client.rb:655:in `batch'
  # # ./vendor/bundle/ruby/3.0.0/gems/google-cloud-firestore-3.1.0/lib/google/cloud/firestore/document_reference.rb:339:in `set'
  # # ./lib/kagaribi/collection.rb:62:in `block in set'
  # # ./lib/kagaribi/collection.rb:141:in `with_retry'
  # # ./lib/kagaribi/collection.rb:60:in `set'
  # # ./spec/kagaribi/collection_spec.rb:8:in `block (3 levels) in <top (required)>'
  # # ./spec/kagaribi/collection_spec.rb:15:in `block (4 levels) in <top (required)>'
  gem "cgi"
end
