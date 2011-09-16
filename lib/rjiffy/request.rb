module Rjiffy
  class Request
    class << self
      def get_data(url)
        response = Configuration.base_uri[url].get.deserialize
        result = Result.new(response).data
      end

      def post_data(url, params)
        response = Configuration.base_uri[url].post_form(params).deserialize
        result = Result.new(response).data
      end

      def delete_data(url)
        Configuration.base_uri[url].delete.deserialize
      end
    end
  end
end
