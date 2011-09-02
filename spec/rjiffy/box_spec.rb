require "spec_helper"

describe Rjiffy::Box do
  before(:all) do
    FakeWeb.register_uri(:get, Rjiffy::Configuration.base_uri["/jiffyBoxes"].to_s, :body => fixture_file("successfull_requested_list.json"), :content_type => "application/json")
    @id = 12345
    FakeWeb.register_uri(:get, Rjiffy::Configuration.base_uri["/jiffyBoxes/#{@id}"].to_s, :body => fixture_file("successfull_requested_box.json"), :content_type => "application/json")
    @box = Rjiffy::Box.find(@id)
  end

  it "list all jiffyboxes" do
    list_of_boxes = Rjiffy::Box.all
    list_of_boxes.map{|box| box.class}.uniq.each do |rjiffy_box|
      rjiffy_box.should == Rjiffy::Box
    end
    list_of_boxes.first.name.should == "Test"
  end

  it "find jiffybox by id" do
    responded_box = Rjiffy::Box.find(@id)
    responded_box.id.should == @id
    responded_box.name.should == "Test"
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
  end

end
