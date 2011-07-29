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

  it "list the backups for the box", :box_backups => true do
    FakeWeb.register_uri(:get, Rjiffy::Configuration.base_uri["/backups/#{@box.id}"].to_s, :body => fixture_file("backup_from_box.json"), :content_type => "application/json")
    backups = @box.backups
    backups.day.should == 1
    backups.daily.created.instance_of?(Fixnum).should be_true
  end


end
