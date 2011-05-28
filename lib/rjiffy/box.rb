module Rjiffy
  class Box
    def initialize(hash)
      hash.each do |k,v|
        self.instance_variable_set("@#{k}", v)  ## create and initialize an instance variable for this key/value pair
        self.class.send(:define_method, k, proc{self.instance_variable_get("@#{k}")})  ## create the getter that returns the instance variable
        self.class.send(:define_method, "#{k}=", proc{|v| self.instance_variable_set("@#{k}", v)})  ## create the setter that sets the instance variable
      end
    end

    def delete
      # TODO
    end

    class << self
      def all
        response =  Rjiffy::Configuration.base_uri["/jiffyBoxes"].get.deserialize
        jiffyboxes = response["result"].collect {|box| self.new(box[1])}
      end

      def find(id)
        response = Rjiffy::Configuration.base_ur["/jiffyBoxes/#{id}"].get.deserialize
        self.new(response["result"])
      end
    end

  end
end
