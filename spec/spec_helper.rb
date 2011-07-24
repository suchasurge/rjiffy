require 'simplecov'
SimpleCov.start if ENV["COVERAGE"]
# use with:
# COVERAGE=true rspec .

$:.push File.expand_path("../lib", __FILE__)
require 'wrest'
require 'fakeweb'

require 'rjiffy'

RSpec.configure do |config|
  config.before(:all) do
    Rjiffy::Configuration.configure do |conf|
      conf.token = "somevalidtoken"
    end
  end
end

def fixture_file(filename)
  return '' if filename == ''
  file_path = File.expand_path(File.dirname(__FILE__) + '/../spec/fixtures/' + filename)
  File.read(file_path)
end
