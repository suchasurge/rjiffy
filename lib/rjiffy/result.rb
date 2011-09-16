module Rjiffy
  class Result
    attr_accessor :data
    def initialize(response)
      @data = process_result(response)
    end


    private

      def process_result(response)
        unless response["result"] == false
          response["result"]
        else
          raise ApiResponseError, response["messages"][0]["message"]
        end
      end

  end
end
