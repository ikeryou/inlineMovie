Entry       = require('../core/Entry')
Profiler    = require('../core/Profiler')
MovieCanvas = require('../mod/MovieCanvas')


# エントリーポイント
class Main extends Entry


  constructor: ->

    super()



  init: =>

    super()

    movie = new MovieCanvas('#movie', './assets/movie/test.mp4')
    movie.init()




module.exports = Main


main = new Main()
main.init()
