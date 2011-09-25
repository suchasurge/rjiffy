module Rjiffy
  class Box < Hashie::Mash
    class << self
      def all
        Request.get_data("/jiffyBoxes").collect {|box| new(box[1])}
      end

      def find(id)
        new(Request.get_data("/jiffyBoxes/#{id}"))
      end

      def create(params = {})
        new(Request.post_data("/jiffyBoxes", params))
      end
    end

    def reload
      merge!(Request.get_data("/jiffyBoxes/#{id}"))
    end

    def delete
      Request.delete_data("/jiffyBoxes/#{id}")
      self.status = "DELETING"
      self
    end

    def backups
      Backup.new(Request.get_data("/backups/#{id}"))
    end

    def thaw(planid)
      merge!(Request.put_data("/jiffyBoxes/#{id}", "status=THAW&planid=#{planid}"))
    end

    [:start, :shutdown, :pullplug, :freeze].each do |method|
      define_method(method) do
        merge!(Request.put_data("/jiffyBoxes/#{id}", "status=#{method.to_s.upcase}"))
      end
    end

  end
end
