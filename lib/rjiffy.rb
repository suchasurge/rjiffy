module Rjiffy
  require 'wrest'

  class << self
    def all
      response = Configuration.base_uri["/jiffyBoxes"].get.deserialize
      result = Result.new(response)
      result.data.collect {|box| Box.new(box[1])}
    end

    def find(id)
      response = Configuration.base_uri["/jiffyBoxes/#{id}"].get.deserialize
      result = Result.new(response)
      Box.new(result.data)
    end
  end

  require 'rjiffy/configuration'
  require 'rjiffy/result'
  require 'rjiffy/box'
  require 'rjiffy/exceptions'
end

class ::Hash
  def method_missing(name)
    return self[name] if key? name
    self.each { |k,v| return v if k.to_s.to_sym == name }
    super.method_missing name
  end
end
