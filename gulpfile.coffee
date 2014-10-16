_ = require 'lodash'
awatch = require 'gulp-autowatch'
browserify = require 'browserify'
buffer = require 'vinyl-buffer'
coffeeify = require 'coffeeify'
concat = require 'gulp-concat'
gulp = require 'gulp'
gutil = require 'gulp-util'
path = require 'path'
plumber = require 'gulp-plumber'
source = require 'vinyl-source-stream'
stylus = require 'gulp-stylus'
{ exec } = require 'child_process'

log = _.bindKey console, 'log'

# paths for autowatch
paths =
  coffee:    './src/**/*.coffee'
  html:      './src/**/*.html'
  stylus:    './src/**/*.styl'
  build:     './build'
  coffeeSrc: './src/app/entry.coffee'

# Compile coffeescript using browserify
# browserify.org
# This lets you require() files instead of using super-awkward module systems, like requirejs or marionette.
# N.B.: There are some pretty easy ways to optimize this! It's slow now, but that can be fixed.
gulp.task 'coffee', ->
  bCache = {}
  b = browserify paths.coffeeSrc,
    fullPaths: true # otherwise it uses numerical indexes
    debug: true
    insertGlobals: false
    cache: bCache
    extensions: ['.coffee']
  b.transform coffeeify
  b.bundle()
  .on 'error', _.bindKey gutil, 'log', 'Browserify Error'
  .pipe source "entry.js"
  .pipe buffer()
  .pipe gulp.dest paths.build
  # .pipe reload()

gulp.task 'html', ->
  gulp.src paths.html
  .pipe gulp.dest paths.build

# Delete everything in the build folder. May not work on windows.. there's a node module for a pure-js version
# of all the unix commands like rm.
gulp.task 'clean', (done) ->
  exec 'rm -rf ./build/*', (err, val) ->
    log err if err?
    done null, val

# Compile the stylesheets using Stylus, which is like Sass but not ruby and more powerful.
# learnboost.github.io/stylus/
# Can also use nib for css3.
# visionmedia.github.io/nib/
gulp.task 'stylus', ->
  gulp.src './src/styles/index.styl'
  .pipe plumber()
  .pipe stylus()
  .pipe concat 'app.css'
  .pipe gulp.dest paths.build

gulp.task 'watch', ->
  awatch gulp, paths

gulp.task 'default', ['coffee', 'html', 'stylus', 'watch']