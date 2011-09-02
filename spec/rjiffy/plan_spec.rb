require 'spec_helper'

describe Rjiffy::Plan do
  it "list all available plans" do
    FakeWeb.register_uri(:get, Rjiffy::Configuration.base_uri["/plans"].to_s, :body => fixture_file("plan_list.json"), :content_type => "application/json")
    plans = Rjiffy::Plan.all
    plans.count.should == 4
    plans.first.class.should == Rjiffy::Plan
    plans.map(&:id).include?(6).should == true
    plans.map(&:name).include?("CloudLevel 1").should == true
  end

  context "finding plans" do
    before(:all) do
      id = URI.escape("1")
      name = URI.escape("CloudLevel 2")
      FakeWeb.register_uri(:get, Rjiffy::Configuration.base_uri["/plans/#{id}"].to_s, :body => fixture_file("plan.json"), :content_type => "application/json")
      FakeWeb.register_uri(:get, Rjiffy::Configuration.base_uri["/plans/#{name}"].to_s, :body => fixture_file("plan.json"), :content_type => "application/json")
    end

    it "by id" do
      plan = Rjiffy::Plan.find(1)
      plan.id.should == 1
      plan.name.should == "CloudLevel 2"
    end

    it "by name" do
      plan = Rjiffy::Plan.find("CloudLevel 2")
      plan.id.should == 1
      plan.name.should == "CloudLevel 2"
    end
  end

end
