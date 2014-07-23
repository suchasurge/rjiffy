module Rjiffy
  class Request
    class << self
      Wrest.logger.level = Configuration.loglevel || Logger::DEBUG

      def get_data(url)
        process_response(Configuration.base_uri[url].get.deserialize)
      end

      def post_data(url, params)
        process_response(Configuration.base_uri[url].post_form(params).deserialize)
      end

      def delete_data(url)
        process_response(Configuration.base_uri[url].delete.deserialize)
      end

      def put_data(url, params)
        process_response(Configuration.base_uri[url].put(params).deserialize)
      end

      private

        def process_response(response)
          Result.new(response).data
        end

    end
  end
end
