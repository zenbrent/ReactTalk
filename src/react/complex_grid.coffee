_ = require 'lodash'
React = require 'react'

# Grab specific elements from React.DOM for brevity's sake:
{ span, i, tr, td, table, thead } = React.DOM

# React is centered around the idea of components:
TableCell = React.createClass
  render: ->
    span {}, [
      @props.cell.num
      i { className: 'fa ' + @props.cell.icon }
    ]

CrazyGrid = React.createClass
  # use component#getInitialState - I did this VERY wrong here.
  render: ->
    table { className: 'crazy-grid' },
      # this.props comes from the object you pass into the component initializer, e.g.
      # React.renderComponent grid({data: gridData}), $('.grid-container')[0]
      # so the grid has this.props.data.
      # When I said I did this wrong, I meant I pass gridData in as a function to call to get the new state.
      # Bad brent! Fixing this is left as an exercise for my coworkers. ;)
      @props.data().map (row, i) ->
        # Create a tr with a bunch of things - Array.map(function(arrayValue){}) creates a new array filled with the
        # return values of the function.
        tr { key: i }, row.map (cell, i) ->
          # Create table cells with a TableCell React component in it:
          td {}, new TableCell { key: i, cell: cell }

# This is what you get when you require() this file.
module.exports = CrazyGrid