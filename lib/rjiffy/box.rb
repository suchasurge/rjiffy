module Rjiffy
  class Box < Hashr
    def delete
      response = Configuration.base_uri["/jiffyBoxes/#{id}"].delete.deserialize
      self.status = Result.new(response).data.status
    end

    def backups
      response = Configuration.base_uri["/backups/#{id}"].get.deserialize
      Backup.new(Result.new(response).data)
    end
  end
end
