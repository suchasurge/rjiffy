## Description

## Configuration
    Rjiffy::Configuration.configure do |conf|
      conf.token = "somevalidtoken"
    end

## Find all boxes
    boxes = Rjiffy.all

## Find one box
    box = Rjiffy.find(ID)

## Delete a box
    box.delete
  This schedules the delete process and sets the box status to "DELETING"
