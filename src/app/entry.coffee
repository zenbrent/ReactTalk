# Import files
$ = require "jquery"
_ = require 'lodash'
React = require 'react'

# Expose them in a libs object just incase you want to play with them.
libs = { $, _, React }
# N.B.:
# If you want to play with react HTML elements in your browser's JS console, this is still pretty clean and easy to type:
# d = libs.React.DOM
# d.a({ className: "some css classes", id: 'whatever'}, [ 'some', 'child', 'text', 'elements!'])

# Set th in the top level scope, otherwise they'll be stuck inside the jquery call at the bottom
layout = null

# Import the React components and set up their data containers:
grid = require '../react/complex_grid.coffee'
gridData = require '../app/grid_data.coffee'

timeList = require '../react/time_list.coffee'
timeData = []

stopButton = require '../react/stop_button.coffee'

# Set up the timer variables
lastUpdate = Date.now()
now = Date.now()

# Because I was too lazy to actually scope this somewhere. :(
window.stopUpdating = false

# The rendering thread.
rerender = ->
  # Call this function asynchronously - the next available execution slot in modern browsers, or 1ms in older.
  _.defer ->
    unless window.stopUpdating
      # Update the grid, then...
      layout.forceUpdate ->
        # Update the current time
        now = Date.now()
        # push it to an array
        timeData.push now - lastUpdate
        # reset the last display time
        lastUpdate = now
    # Recursively call the renderer.
    rerender()

# Once the DOM is available, render the react widgets and start the rendering loop.
{ div } = React.DOM

PageLayout = React.createClass
  render: ->
    div {}, [
      div { className: "stop-button-container" }, new grid({data: gridData})
      div { className: "grid-container" }, new timeList({collection: timeData})
      div { className: "times-container" }, new stopButton()
    ]

$ ->
  layout = React.renderComponent PageLayout({}), $('body')[0]
  _.defer rerender