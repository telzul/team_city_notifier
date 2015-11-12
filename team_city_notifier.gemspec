# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'team_city_notifier/version'

Gem::Specification.new do |spec|
  spec.name          = "team_city_notifier"
  spec.version       = TeamCityNotifier::VERSION
  spec.authors       = ["DarthMax"]
  spec.email         = ["max@kopfueber.org"]
  spec.summary       = %q{Get Notifications for TeamCity builds}
  spec.description   = %q{Get Notifications for TeamCity builds using libnotify}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'libnotify', '~> 0.9.1'
  spec.add_dependency 'daemons', '~> 1.2.3'
  spec.add_dependency 'httparty', '~> 0.13.5'
  spec.add_dependency 'timers', '~> 4.0.1'
  spec.add_dependency 'rake', '~> 10.4.2'

end
