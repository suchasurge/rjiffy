module Rjiffy
  class Plan < Hashie::Mash
    class << self
      def all
        Request.get_data("/plans").collect {|plan| new(plan[1])}
      end

      def find(id_or_name)
        escaped_id_or_name = URI.escape(id_or_name.to_s)
        new(Request.get_data("/plans/#{escaped_id_or_name}"))
      end
    end
  end
end
