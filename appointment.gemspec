# -*- encoding: utf-8 -*-
require File.expand_path('../lib/core/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Markus Krogemann"]
  gem.email         = ["markus@krogemann.de"]
  gem.description   = %q{A gem that supports creating appointments}
  gem.summary       = %q{Appointments}
  gem.homepage      = "https://github.com/mkrogemann/appointment"
  gem.license       = 'MIT'

  gem.files         = Dir['lib/**/*.rb']
  gem.test_files    = []
  gem.name          = "appointment"
  gem.require_paths = ["lib"]
  gem.version       = Core::VERSION

  gem.add_development_dependency('rspec', '~> 2.14.1')
  gem.add_development_dependency('cucumber', '~> 1.3.6')
  gem.add_development_dependency('simplecov', '~> 0.8.2')
  gem.add_development_dependency('metric_fu', '~> 4.11.1') unless ENV['TRAVIS'] == 'true'
end
