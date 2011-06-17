## Description

## Configuration
    Rjiffy::Configuration.configure do |conf|
      conf.token = "somevalidtoken"
    end

## Find all boxes
    boxes = Rjiffy::Box.all

## Find one box
    box = api.find(ID)
