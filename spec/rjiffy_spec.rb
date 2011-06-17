require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe Rjiffy do

  describe "basic handling for jiffyboxes" do
    it "list all jiffyboxes" do
      FakeWeb.register_uri(:get, Rjiffy::Configuration.base_uri["/jiffyBoxes"].to_s, :body => fixture_file("successfull_requested_list.json"), :content_type => "application/json")
      list_of_boxes = Rjiffy.all
      list_of_boxes.map{|box| box.class}.uniq.each do |rjiffy_box|
        rjiffy_box.should == Rjiffy::Box
      end
      list_of_boxes.first.name.should == "Test"
    end

    it "find jiffybox by id" do
      id = 12345
      FakeWeb.register_uri(:get, Rjiffy::Configuration.base_uri["/jiffyBoxes/#{id}"].to_s, :body => fixture_file("successfull_requested_box.json"), :content_type => "application/json")
      responded_box = Rjiffy.find(id)
      responded_box.id.should == id
      responded_box.name.should == "Test"
    end
  end

  describe "handle errors", :handle_errors => true do
    it "handles api errors in response" do
      FakeWeb.register_uri(:get, Rjiffy::Configuration.base_uri["/jiffyBoxes"].to_s, :body => fixture_file("error_response.json"), :content_type => "application/json")
      expect { Rjiffy.all }.to raise_error(Rjiffy::ApiResponseError, "Der von Ihnen uebergebene API-Token ist ungueltig.")
    end

    it "handles api 400/500 errors" do
      pending "waiting to implement"
    end
  end

end
