MyDisplay = require('../core/MyDisplay')
Func      = require('../core/Func')
Conf      = require('../core/Conf')
Util      = require('../libs/Util')


class Canvas extends MyDisplay


  constructor: (sel) ->

    super({
      update:true
      resize:true
      el:$(sel)
    })

    @camera
    @renderer
    @mainScene



  # -----------------------------------------------
  # 初期化
  # -----------------------------------------------
  init: =>

    super()

    @_makeCamera()
    @_makeRenderer()
    @_makeMainScene()



  # -----------------------------------------------
  # 更新
  # -----------------------------------------------
  _update: =>

    super()

    @renderer.autoClear = true
    @renderer.render(@mainScene, @camera)



  # -----------------------------------------------
  # リサイズ
  # -----------------------------------------------
  _resize: =>

    # 画面サイズ
    w = window.innerWidth
    h = window.innerHeight

    @camera.aspect = w / h
    @camera.updateProjectionMatrix()

    @renderer.setPixelRatio(window.devicePixelRatio || 1)
    @renderer.setSize(w, h, true)
    @renderer.clear()



  # -----------------------------------------------
  # カメラ作成
  # -----------------------------------------------
  _makeCamera: =>

    @camera = new THREE.PerspectiveCamera(90, 1, 0.1, 50000)



  # -----------------------------------------------
  # レンダラー作成
  # -----------------------------------------------
  _makeRenderer: =>

    @renderer = new THREE.WebGLRenderer({
      canvas             : document.getElementById(@el().attr('id'))
      alpha              : false
      antialias          : false
      stencil            : false
      depth              : true
      premultipliedAlpha : false
    })
    @renderer.setClearColor(0xffffff)



  # -----------------------------------------------
  # メインシーン作成
  # -----------------------------------------------
  _makeMainScene: =>

    @mainScene = new THREE.Scene()










module.exports = Canvas
