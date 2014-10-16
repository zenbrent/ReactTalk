# Some configuration options:

# I show one icon a lot more so you can check the debugger to see if it's actually not re-rendering.
# Change the value of thumbsUpQuantity above to increase/decrease this icon's frequency.
thumbsUpQuantity = 20

# The number of rows and columns for the crazy grid:
columns = 12
rows = 100
# Creating a widget to update the rows and columns is an exercise left for my coworkers.

# imports
_ = require 'lodash'

# An array of icons
icons = [
  'fa-arrow-circle-down'
  'fa-arrow-circle-left'
  'fa-arrow-circle-o-right'
  'fa-arrow-circle-o-up'
  'fa-arrow-circle-right'
  'fa-arrow-circle-up'
  'fa-arrow-down'
  'fa-arrow-left'
  'fa-arrow-right'
  'fa-arrow-up'
  'fa-arrows-h'
  'fa-cc-paypal'
  'fa-cc-discover'
  'fa-cc-visa'
  'fa-cc-paypal'
  'fa-cc-mastercard'
  'fa-check'
  'fa-child'
  'fa-facebook'
  'fa-wifi'
]
_.times thumbsUpQuantity, -> icons.push 'fa-thumbs-o-up'

# Well, I tried optimizing...
iconCount = icons.length
getRandomStr = ->
  if Math.random() > .5
  then Math.random().toString(36).slice(2, 10)
  else '★★★'

# A function to make an M by N grid of these: { num: <RandomNumber>, icon: <String of a FontAwesome icon> }
# Definitely not optimized.
getData = ->
  # Use for loops because they're significantly faster when nested than functional iterators.
  for row in [1..rows]
    for col in [1..columns]
      {
        num: getRandomStr()
        icon: icons[_.random(0,iconCount,false)]
      }

module.exports = getData