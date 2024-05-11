# Kagaribi(篝火) :fire:
Simple client for [Cloud Firestore](https://cloud.google.com/firestore)

[![Gem Version](https://badge.fury.io/rb/kagaribi.svg)](https://badge.fury.io/rb/kagaribi)
[![test](https://github.com/sue445/kagaribi/actions/workflows/test.yml/badge.svg)](https://github.com/sue445/kagaribi/actions/workflows/test.yml)

## Installation
Install the gem and add to the application's Gemfile by executing:

```bash
$ bundle add kagaribi
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
$ gem install kagaribi
```

## Usage
### Authentication
Pass environment variables for Firestore authentication

see https://cloud.google.com/ruby/docs/reference/google-cloud-firestore/latest/AUTHENTICATION

### Requirements
Firestore CRUD(Create/Read/Update/Delete) requires at least the following IAM Role

* [Cloud Datastore User](https://cloud.google.com/iam/docs/understanding-roles#datastore.user) (`roles/datastore.user`)

### Simple usage
```ruby
require "kagaribi"

collection = Kagaribi.collection("users")

collection.set("sue445", name: "sue445", url: "https://github.com/sue445")

collection.get("sue445")
#=> { name: "sue445", url: "https://github.com/sue445" }
```

All methods are followings

https://sue445.github.io/kagaribi/Kagaribi/Collection

## Development
At first, install [Firebase Local Emulator Suite](https://firebase.google.com/docs/emulator-suite/install_and_configure)

Mac 

```bash
brew install firebase-cli
```

Unix

```bash
sudo wget https://firebase.tools/bin/linux/latest -O /usr/local/bin/firebase --quiet
sudo chmod 755 /usr/local/bin/firebase
firebase setup:emulators:firestore
```

Run tests with Firebase Local Emulator

```bash
bundle exec rake spec
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sue445/kagaribi.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
