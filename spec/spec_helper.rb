$:.push File.expand_path("../lib", __FILE__)
require "wrest"

require "rjiffy"

# TODO
# Think about fixtures and create some that make really sense.
#
def successfull_requested_box
  {"id"=>12345,"name"=>"DeathStar"}
end

def successfull_requested_box_list
  [Rjiffy::Box.new(successfull_requested_box)]
end

def error_response
  {"messages"=>[{"type"=>"error", "message"=>"Der von Ihnen uebergebene API-Token ist ungueltig."}], "result"=>false}
end
