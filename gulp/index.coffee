config = require('./config')
gulp = require('gulp')
path = require('path')
plumber = require('gulp-plumber')
notify = require('gulp-notify')
sass = require('gulp-sass')
autoprefixer = require('gulp-autoprefixer')
minifyCSS = require('gulp-minify-css')
gutil = require('gulp-util')
combineMediaQueries = require('gulp-combine-media-queries')



gulp.task 'styles', ->
  gulp.src('./css/**/!(_)*.s[a|c]ss')
  .pipe plumber({errorHandler: notify.onError("Error: <%= error.message %>")})
  .pipe sass(
    # indentedSyntax: true
    onError: notify.onError((error)->
      file = error.file.replace(path.join(process.cwd(), './'),'')
      console.log(JSON.stringify(error,0,4))
      return {
      title: "#{file}@#{error.line}:#{error.column}"
      message: error.message
      }
    )
  )
  .pipe autoprefixer(
    browsers: [
      'last 2 versions'
      'safari 5'
      'ie 8'
      'ie 9'
      'opera 12.1'
      'ios 6'
      'android 4'
    ]
  )
  .pipe combineMediaQueries()
  .pipe if config.isProduction
    minifyCSS(keepBreaks:true)
  else
    gutil.noop()
  .pipe gulp.dest('./css/')



gulp.task 'build', ['styles']
gulp.task 'default', ['watch']

gulp.task 'watch', ['build'], ()->
  gulp.watch("./css/**/*", ['styles'])