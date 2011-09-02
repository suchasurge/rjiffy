module Rjiffy
  class Distribution < Hashie::Mash
    class << self
      def all
        response = Configuration.base_uri["/distributions"].get.deserialize
        result = Result.new(response)
        result.data.collect {|distribution| new(add_id_to_result(distribution[0],distribution[1]))}
      end

      def find(id)
        response = Configuration.base_uri["/distributions/#{id}"].get.deserialize
        result = Result.new(response)
        new(add_id_to_result(id, result.data))
      end

      private

        def add_id_to_result(id, result)
          result.id = id
          result
        end

    end
  end
end
