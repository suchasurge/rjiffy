require 'spec_helper'

describe Rjiffy::Distribution do

  it "list all available distributions" do
    FakeWeb.register_uri(:get, Rjiffy::Configuration.base_uri["/distributions"].to_s, :body => fixture_file("distributions_list.json"), :content_type => "application/json")
    distributions = Rjiffy::Distribution.all
    distributions.count.should == 2
    last_distribution = distributions.last
    last_distribution.class.should == Rjiffy::Distribution
    last_distribution.name.should == "CentOS 5.4 64-Bit"
    last_distribution.id.should == "centos_5_4_64bit"
  end

  it "find distribution by id" do
    distribution_id = "centos_5_4_64bit"
    FakeWeb.register_uri(:get, Rjiffy::Configuration.base_uri["/distributions/#{distribution_id}"].to_s, :body => fixture_file("distribution.json"), :content_type => "application/json")
    distribution = Rjiffy::Distribution.find(distribution_id)
    distribution.id.should == distribution_id
    distribution.rootdiskMode.should == "ro"
    distribution.class.should == Rjiffy::Distribution
  end

end
