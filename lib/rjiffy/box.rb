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
      response = Rjiffy::Configuration.base_uri["/jiffyBoxes/#{id}"].delete.deserialize
      unless response["result"] == false
        self.status = response["result"]["status"]
      else
        raise ApiResponseError, response["messages"][0]["message"]
      end
    end

  end
end
