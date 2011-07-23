require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe Rjiffy do

  describe "basic handling for jiffyboxes" do
    it "handles empty results" do
      FakeWeb.register_uri(:get, Rjiffy::Configuration.base_uri["/jiffyBoxes"].to_s, :body => fixture_file("empty_result.json"), :content_type => "application/json")
      box_list = Rjiffy.all
      box_list.class.should == Array
      box_list.should be_empty
    end

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

    it "list the backups for all available boxes" do
      FakeWeb.register_uri(:get, Rjiffy::Configuration.base_uri["/backups"].to_s, :body => fixture_file("backup_list.json"), :content_type => "application/json")
      available_backups = Rjiffy.backups
      available_backups.class.should == Array
      available_backups.count.should == 1
      backup = available_backups.first
      backup.daily.id.should == "1234567890abcdef1234567890abcdef"
      backup.weekly.created == 1234567890
      backup.biweekly.id == "34567890abcdef1234567890abcdef12"
    end
  end

  describe "Errors", :handle_errors => true do
    it "handles api errors in response" do
      FakeWeb.register_uri(:get, Rjiffy::Configuration.base_uri["/jiffyBoxes"].to_s, :body => fixture_file("error_response.json"), :content_type => "application/json")
      expect { Rjiffy.all }.to raise_error(Rjiffy::ApiResponseError, "Der von Ihnen uebergebene API-Token ist ungueltig.")
    end

    it "handles api 400/500 response codes" do
      pending "waiting to implement"
    end
  end

end
