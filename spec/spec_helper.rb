$:.push File.expand_path("../lib", __FILE__)
require "wrest"
require 'fakeweb'

require "rjiffy"


def fixture_file(filename)
  return '' if filename == ''
  file_path = File.expand_path(File.dirname(__FILE__) + '/../spec/fixtures/' + filename)
  File.read(file_path)
end
