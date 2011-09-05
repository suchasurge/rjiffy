[![Build Status](https://secure.travis-ci.org/suchasurge/rjiffy.png)](http://travis-ci.org/suchasurge/rjiffy)

## Description
Ruby Wrapper for jiffybox.de API

## Configuration
    Rjiffy::Configuration.configure do |conf|
      conf.token = "somevalidapitoken"
    end

## List all backups
    backups = Rjiffy.backups

## Find all boxes
    boxes = Rjiffy::Box.all

## Find one box
    box = Rjiffy::Box.find(ID)

## Delete a box
    box.delete
  This triggers the delete process. On success the new status for the box is set to "DELETING"

## List all plans
    Rjiffy::Plan.all

## Find a specific plan
    Rjiffy::Plan.find("CloudLevel 2")
or
    
    Rjiffy::Plan.find(1)

## List all distributions
    Rjiffy::Distribution.all

## Find a specific distribution
    Rjiffy::Distribution.find("centos_5_4_64bit")

## Todo
* Improve Error Handling
* Tweak Readme
* Implement all stuff we can do with the jiffybox API
