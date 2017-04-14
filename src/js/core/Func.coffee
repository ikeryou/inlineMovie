Util    = require('../libs/Util')
Resize  = require('../libs/Resize')
Size    = require('../libs/obj/Size')
Conf    = require('./Conf')

# 共通関数
class Func

  constructor: ->



  # ------------------------------------
  # レティナのあの値
  # ------------------------------------
  ratio: =>

    return window.devicePixelRatio || 1



  # ------------------------------------
  # コクのあるサイン 1
  # ------------------------------------
  sin1: (radian) =>

    return Math.sin(radian) + Math.sin(2 * radian)



  # ------------------------------------
  # コクのあるサイン 2
  # ------------------------------------
  sin2: (radian) =>

    return (
      Math.sin(radian) +
      Math.sin(2.2 * radian + 5.52) +
      Math.sin(2.9 * radian + 0.93) +
      Math.sin(4.6 * radian + 8.94)
    ) / 4



  # ------------------------------------
  # TweenMaxのラッパー関数
  # ------------------------------------
  a: (target, param, duration, delay, easing, callback) =>

    TweenMax.killTweensOf(target)

    from = {}
    to = {}
    for key,val of param
      from[key] = val[0]
      to[key]   = val[1]

      if !target[key]?
        target[key] = val[0]

    TweenMax.set(target, from)

    if easing?
      to.ease = easing

    if delay?
      to.delay = delay

    if callback?
      to.onComplete = callback

    TweenMax.to(target, duration, to)








module.exports = new Func()
