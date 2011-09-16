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
  end
end
