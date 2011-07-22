![travis-ci build status](http://travis-ci.org/suchasurge/rjiffy.png)

## Description
Ruby Wrapper for jiffybox.de API

## Configuration
    Rjiffy::Configuration.configure do |conf|
      conf.token = "somevalidapitoken"
    end

## Find all boxes
    boxes = Rjiffy.all

## Find one box
    box = Rjiffy.find(ID)

## Delete a box
    box.delete
  This triggers the delete process. On success the new status for the box is set to "DELETING"

## Todo
* Improve Error Handling
* Tweak Readme
* Implement all stuff we can do with the jiffybox API
