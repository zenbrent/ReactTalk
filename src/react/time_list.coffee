_ = require 'lodash'
React = require 'react'
{ div } = React.DOM

# Find the average of items in an array:
avgList = (list) ->
  sum = _.reduce list, (sum, num) -> sum + num
  return Math.round sum / list.length

TimeList = React.createClass
  render: ->
    avg = avgList @props.collection
    slicePoint = if @props.collection.length > 20 then @props.collection.length - 20 else 0
    recentAvg = avgList @props.collection.slice slicePoint
    div { className: "time-list" },
      div { className: 'time average' }, ["Render Time Average: ", avg]
      div { className: 'time average' }, ["Avg. of Last 20: ", recentAvg]
      _.map @props.collection.slice(slicePoint), (time) ->
        div { className: 'time' }, time

# This is what you get when you require this file.
module.exports = TimeList