if ENV['COVERAGE'] == 'true'
  require 'simplecov'
end

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require 'core'
