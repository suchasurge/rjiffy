require 'spec_helper'

describe Rjiffy::Plan do
  it "list all available plans" do
    FakeWeb.register_uri(:get, Rjiffy::Configuration.base_uri["/plans"].to_s, :body => fixture_file("plan_list.json"), :content_type => "application/json")
    @plans = Rjiffy::Plan.all
    @plans.count.should == 4
    first_plan = @plans.first
    first_plan.class.should == Rjiffy::Plan
    first_plan.id.should == 6
    first_plan.name.should == "CloudLevel 1"
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
      puts plan.inspect
      plan.id.should == 1
      plan.name.should == "CloudLevel 2"
    end

    it "by name" do
      plan = Rjiffy::Plan.find("CloudLevel 2")
      puts plan.inspect
      plan.id.should == 1
      plan.name.should == "CloudLevel 2"
    end
  end

end
