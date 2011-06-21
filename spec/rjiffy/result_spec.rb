require 'spec_helper'

describe Rjiffy::Result do

  it "returns the result from a response" do
    response = {"messages" => [], "result" => {"id" => 12345, "name" => "Test"}}
    result = Rjiffy::Result.new(response)
    result.data.id.should == 12345
    result.data.name.should == "Test"
  end

  it "raises error on failure response" do
    error_response = {"messages" => [{"type" => "error", "message" => "Der von Ihnen uebergebene API-Token ist ungueltig."}],"result" => false}
    expect { Rjiffy::Result.new(error_response) }.to raise_error(Rjiffy::ApiResponseError, "Der von Ihnen uebergebene API-Token ist ungueltig.")
  end

end
