require "spec_helper"

describe Rjiffy::Box do

  before(:each) do
    Rjiffy::Configuration.configure do |conf|
      conf.token = "somevalidtoken"
    end
  end

  it "list all jiffyboxes" do
    Rjiffy.should_receive(:all).and_return(successfull_requested_box_list)
    list_of_boxes = Rjiffy.all
    list_of_boxes.map{|box| box.class}.uniq.each do |rjiffy_box|
      rjiffy_box.should == Rjiffy::Box
    end
    list_of_boxes.first.name == "DeathStar"
  end

  it "find jiffybox by id" do
    box = double('Box', successfull_requested_box)
    id = 12345
    #id = 11243
    Rjiffy.should_receive(:find).with(id).and_return(box)
    responded_box = Rjiffy.find(id)
    responded_box.id.should == id
    responded_box.name.should == "DeathStar"
  end

end
