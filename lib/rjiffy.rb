module Rjiffy
  require 'wrest'
  require 'hashie'

  class << self
    def all
      response = Configuration.base_uri["/jiffyBoxes"].get.deserialize
      result = Result.new(response)
      result.data.collect {|box| Box.new(box[1])}
    end

    def find(id)
      response = Configuration.base_uri["/jiffyBoxes/#{id}"].get.deserialize
      result = Result.new(response)
      Box.new(result.data)
    end

    def backups
      response = Configuration.base_uri["/backups"].get.deserialize
      result = Result.new(response)
      result.data.collect {|backup| Backup.new(backup[1])}
    end
  end

  require 'rjiffy/configuration'
  require 'rjiffy/result'
  require 'rjiffy/backup'
  require 'rjiffy/box'
  require 'rjiffy/plan'
  require 'rjiffy/exceptions'
end
