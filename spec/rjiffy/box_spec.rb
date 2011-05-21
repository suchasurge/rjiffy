require "spec_helper"

describe Rjiffy::Box do

  before(:all) do
    @connection = Rjiffy::Connection.new("validapitokenhere")
  end

  it "list all jiffyboxes" do
    Rjiffy::Box.should_receive(:all).and_return(successfull_requested_box_list)
    list_of_boxes = Rjiffy::Box.all
    list_of_boxes.class.should == Hash
  end

  it "find jiffybox by id" do
    box = double('Box', successfull_requested_box)
    id = 12345
    Rjiffy::Box.should_receive(:find).with(id).and_return(box)
    Rjiffy::Box.find(id)
    box.id.should == id
    box.name.should == "DeathStar"
  end

end
