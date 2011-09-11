module Rjiffy
  class Box < Hashie::Mash
    class << self
      def all
        response = Configuration.base_uri["/jiffyBoxes"].get.deserialize
        result = Result.new(response)
        result.data.collect {|box| new(box[1])}
      end

      def find(id)
        response = Configuration.base_uri["/jiffyBoxes/#{id}"].get.deserialize
        result = Result.new(response)
        new(result.data)
      end

      def create(params = {})
        response = Configuration.base_uri["/jiffyBoxes"].post_form(params).deserialize
        result = Result.new(response)
        new(result.data)
      end
    end

    def delete
      response = Configuration.base_uri["/jiffyBoxes/#{id}"].delete.deserialize
      self.status = "DELETING"
      self
    end

    def backups
      response = Configuration.base_uri["/backups/#{id}"].get.deserialize
      Backup.new(Result.new(response).data)
    end
  end
end
