module Rjiffy
  class Plan < Hashie::Mash
    class << self
      def all
        response = Configuration.base_uri["/plans"].get.deserialize
        result = Result.new(response)
        result.data.collect {|plan| new(plan[1])}
      end

      def find(id_or_name)
        escaped_id_or_name = URI.escape(id_or_name.to_s)
        response = Configuration.base_uri["/plans/#{escaped_id_or_name}"].get.deserialize
        Plan.new(Result.new(response).data)
      end
    end
  end
end
