isDevelopment   = process.argv[2] == undefined

module.exports =
  isWatching: isDevelopment
  isDevelopment: isDevelopment
  isProduction: !isDevelopment
  dir:
    src:
      base: './'
      styles: './css/'
    build:
      base: './'
