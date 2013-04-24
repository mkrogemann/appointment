# -*- encoding: utf-8 -*-
require File.expand_path('../lib/core/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Markus Krogemann"]
  gem.email         = ["markus@krogemann.de"]
  gem.description   = %q{oO: Appointments, ... waiting for Inspquo}
  gem.summary       = %q{Appointments}
  gem.homepage      = "https://github.com/ruby-spa/appointment"
  gem.license       = 'MIT'

  gem.files         = Dir['lib/**/*.rb']
  gem.test_files    = []
  gem.name          = "appointment"
  gem.require_paths = ["lib"]
  gem.version       = Core::VERSION

  gem.add_development_dependency('rspec', '~> 2.13.0')
  gem.add_development_dependency('cucumber', '~> 1.2.3')
  gem.add_development_dependency('simplecov', '~> 0.7.1')
end
