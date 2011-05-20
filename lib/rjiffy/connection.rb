module Rjiffy
  class Connection
    include HTTParty

    API_VERSION = "v1.0"

    def initialize(token)
      self.class.base_uri "https://api.jiffybox.de/#{token}/#{API_VERSION}"
    end

    def list_boxes
      response = self.class.get("/jiffyBoxes")
      response["result"]
    end

    def find(id)
      response = self.class.get("/jiffyBoxes/#{id}")
      Box.new(response["result"])
    end

  end
end
