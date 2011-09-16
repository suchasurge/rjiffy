require "spec_helper"

describe Rjiffy::Box do
  before(:all) do
    FakeWeb.register_uri(:get, Rjiffy::Configuration.base_uri["/jiffyBoxes"].to_s, :body => fixture_file("box_list.json"), :content_type => "application/json")
    @id = 12345
    FakeWeb.register_uri(:get, Rjiffy::Configuration.base_uri["/jiffyBoxes/#{@id}"].to_s, :body => fixture_file("box.json"), :content_type => "application/json")
    FakeWeb.register_uri(:delete, Rjiffy::Configuration.base_uri["/jiffyBoxes/#{@id}"].to_s, :body => fixture_file("deleted_box.json"), :content_type => "application/json")
    FakeWeb.register_uri(:get, Rjiffy::Configuration.base_uri["/backups/#{@id}"].to_s, :body => fixture_file("backup_from_box.json"), :content_type => "application/json")
    FakeWeb.register_uri(:post, Rjiffy::Configuration.base_uri["/jiffyBoxes"].to_s, :body => fixture_file("created_box.json"), :content_type => "application/json")
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
    @box.delete
    @box.status.should == "DELETING"
  end

  it "list the backups for the box", :box_backups => true do
    backups = @box.backups
    backups.day.should == 1
  end

  it "creates a new jiffybox", :create_jiffybox => true do
    params = {:name => "Test", :planid => "1", :distribution => "centos_5_6_32bit"}
    box = Rjiffy::Box.create(params)
    box.status.should == "CREATING"
  end

  it "reloads the box to update data", :reload_jiffybox => true do
    box = Rjiffy::Box.create({:name => "Test", :planid => "1", :distribution => "centos_5_6_32bit"})
    box.status.should == "CREATING"
    box.name.should == "Test"
    id_from_created_box = box.id
    created_at = box.created
    box.reload
    box.status.should == "READY"
    box.created.should == created_at
    box.id.should == id_from_created_box
  end

end
