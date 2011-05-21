require "spec_helper"

describe  Rjiffy::Connection do


  it "builds the base_uri for further api calls" do
    connection = Rjiffy::Connection.new("somevalidapitoken")
    connection.class.base_uri.should == "https://api.jiffybox.de/somevalidapitoken/v1.0"
  end

end
