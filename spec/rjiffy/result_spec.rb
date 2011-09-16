require 'spec_helper'

describe Rjiffy::Result do

  it "raises error on failure response" do
    error_response = {"messages" => [{"type" => "error", "message" => "Der von Ihnen uebergebene API-Token ist ungueltig."}],"result" => false}
    expect { Rjiffy::Result.new(error_response) }.to raise_error(Rjiffy::ApiResponseError, "Der von Ihnen uebergebene API-Token ist ungueltig.")
  end

  it "returns the raw data from a response" do
    Rjiffy::Result.new({"result" => {:test => "whatever"}}).data.class.should == Hash
    Rjiffy::Result.new({"result" => true}).data.class.should == TrueClass
    Rjiffy::Result.new({"result" => "whatever"}).data.class.should == String
  end

end
