$:.push File.expand_path("../lib", __FILE__)
require "httparty"

require "rjiffy"

# TODO
# Think about fixtures and create some that make really sense.
#
def successfull_requested_box
  {"id"=>12345,"name"=>"DeathStar"}
end

def successfull_requested_box_list
  {}
end

def error_response
  [{"type"=>"error", "message"=>"Some error message"}]
end
