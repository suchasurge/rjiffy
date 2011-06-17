require "spec_helper"

describe Rjiffy::Box do
  before(:all) do
    id = 12345
    FakeWeb.register_uri(:get, Rjiffy::Configuration.base_uri["/jiffyBoxes/#{id}"].to_s, :body => fixture_file("successfull_requested_box.json"), :content_type => "application/json")
    @box = Rjiffy.find(id)
  end

  it "deletes a box" do
    FakeWeb.register_uri(:delete, Rjiffy::Configuration.base_uri["/jiffyBoxes/#{@box.id}"].to_s, :body => fixture_file("successfull_deleted_box.json"), :content_type => "application/json")
    @box.delete
    @box.status.should == "DELETING"
  end


end
