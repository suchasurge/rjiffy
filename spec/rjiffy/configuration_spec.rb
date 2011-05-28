require "spec_helper"

describe  Rjiffy::Configuration do


  it "sets the config variables and build the base_url" do
    Rjiffy::Configuration.configure {|conf| conf.token = "mytoken"}
    Rjiffy::Configuration.token.should == "mytoken"
    Rjiffy::Configuration.base_uri.should == "https://api.jiffybox.de/mytoken/v1.0".to_uri
  end

end
