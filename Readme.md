# Description [![Build Status](https://secure.travis-ci.org/suchasurge/rjiffy.png)](http://travis-ci.org/suchasurge/rjiffy)
Ruby Wrapper for jiffybox.de API

## Configuration
    Rjiffy::Configuration.configure do |conf|
      conf.token = "somevalidapitoken"
    end

## List all backups
    Rjiffy.backups

## Find all boxes
    Rjiffy::Box.all

## Find one box
    box = Rjiffy::Box.find(ID)

## Reload a box
    box.reload

## Delete a box
    box.delete
  This triggers the delete process. On success the new status for the box is set to "DELETING"

## Create a box
    Rjiffy::Box.create({:name => "Test", :planid => "1", :distribution => "centos_5_6_32bit"})

## Start, shutdown, pullplug, freeze and thaw a box
`box.start`, `box.shutdown`, `box.pullplug`, `box.freeze`, `box.thaw(PLANID)`

## List all plans
    Rjiffy::Plan.all

## Find a specific plan
    Rjiffy::Plan.find("CloudLevel 2")
or use an id

    Rjiffy::Plan.find(1)

## List all distributions
    Rjiffy::Distribution.all

## Find a specific distribution
    Rjiffy::Distribution.find("centos_5_4_64bit")

## Todo
* Improve Error Handling
* Tweak Readme
* Implement all stuff we can do with the jiffybox API
