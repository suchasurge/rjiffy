module Rjiffy
  class Box < Hashr
    def delete
      response = Configuration.base_uri["/jiffyBoxes/#{id}"].delete.deserialize
      self.status = Result.new(response).data.status
    end

  end
end
