require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe Rjiffy do

  before(:each) do
    Rjiffy::Configuration.configure do |conf|
      conf.token = "somevalidtoken"
    end
  end

  describe "basic handling for jiffyboxes" do
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

  describe "handle errors", :handle_errors => true do
    it "handles api errors in response" do
      Rjiffy.should_receive(:all).and_raise(Rjiffy::ApiResponseError.new(error_response["messages"][0]["message"]))
      expect { Rjiffy.all }.to raise_error(Rjiffy::ApiResponseError, "Der von Ihnen uebergebene API-Token ist ungueltig.")
    end

    it "handles api 400/500 errors" do
      pending
    end
  end

end
