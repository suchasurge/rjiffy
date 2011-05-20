require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe Rjiffy do

  before(:all) do
    #TODO: stub request
    @connection = Rjiffy::Connection.new("sjdhakjsdhkajsdhak")
  end

  it "list all jiffyboxes" do
    @connection.list_boxes.class.should == Hash
    # test if the data are like the jiffybox api specification
  end

  it "find jiffybox by id" do
    id = 11243
    box = @connection.find(id)
    box.name.should == "DeathStar"
    box.class.should == Box
  end

  it "should delete specific jiffybox" do
    # test delete
  end

end
