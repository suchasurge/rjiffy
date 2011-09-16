module Rjiffy
  class Distribution < Hashie::Mash
    class << self
      def all
        Request.get_data("/distributions").collect {|distribution| new(add_id_to_result(distribution[0],distribution[1]))}
      end

      def find(id)
        new(add_id_to_result(id, Request.get_data("/distributions/#{id}")))
      end

      private

        def add_id_to_result(id, result)
          result["id"] = id
          result
        end

    end
  end
end
