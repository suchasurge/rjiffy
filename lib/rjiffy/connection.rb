module Rjiffy
  class Connection
    include HTTParty

    API_VERSION = "v1.0"

    def initialize(token)
      self.class.base_uri "https://api.jiffybox.de/#{token}/#{API_VERSION}"
    end


  end
end
