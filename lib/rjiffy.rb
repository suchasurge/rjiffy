module Rjiffy
  require 'wrest'
  require 'rjiffy/configuration'
  require 'rjiffy/box'

  class << self
    def all
      response =  Rjiffy::Configuration.base_uri["/jiffyBoxes"].get.deserialize
      jiffyboxes = response["result"].collect {|box| Box.new(box[1])}
    end

    def find(id)
      response = Rjiffy::Configuration.base_uri["/jiffyBoxes/#{id}"].get.deserialize
      Box.new(response["result"])
    end
  end

end

class ::Hash
  def method_missing(name)
    return self[name] if key? name
    self.each { |k,v| return v if k.to_s.to_sym == name }
    super.method_missing name
  end
end
