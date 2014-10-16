_ = require 'lodash'
React = require 'react'
{ a, i } = React.DOM

StopButton = React.createClass
  render: ->
    # Create a link that calls this.@toggleUpdating when clicked:
    a { className: 'stop-button', href:'', onClick: @toggleUpdating },
      if window.stopUpdating
      then [(i { className: 'fa fa-play' }), 'Start']
      else [(i { className: 'fa fa-pause' }), 'Stop']

  # Attach event handlers to the component
  toggleUpdating: (e) ->
    e.preventDefault()
    # Toggle some global state (blech!!!!) and re-render this component:
    window.stopUpdating = !window.stopUpdating
    @forceUpdate()

module.exports = StopButton