module Rjiffy
  require 'wrest'
  require 'hashie'

  class << self
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
  require 'rjiffy/distributions'
  require 'rjiffy/exceptions'
end
