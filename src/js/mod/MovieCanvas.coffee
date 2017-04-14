Util   = require('../libs/Util')
Func   = require('../core/Func')
Canvas = require('./Canvas')


# 映像再生用 Canvas
class MovieCanvas extends Canvas


  constructor: (sel, movSrc) ->

    super(sel)

    # 動画
    @_movSrc = movSrc

    # videoタグ
    @_video

    # テクスチャ
    @_tex

    # 映像表示するMesh
    @_movMesh



  # -----------------------------------------------
  # 初期化
  # -----------------------------------------------
  init: =>

    super()

    @_video = document.createElement('video')
    @_video.preload = 'none'
    @_video.autoplay = false
    @_video.loop = true

    @_tex = new THREE.VideoTexture(@_video)
    @_tex.minFilter = THREE.LinearFilter
    @_tex.magFilter = THREE.LinearFilter
    @_tex.format = THREE.RGBFormat

    @_movMesh = new THREE.Mesh(
      new THREE.PlaneBufferGeometry(1,1),
      new THREE.ShaderMaterial({
        vertexShader:require('../../shader/Movie.vert')
        fragmentShader:require('../../shader/Movie.frag')
        uniforms:{
          tDiffuse:{type:'t', value:@_tex}
          time:{type:'f', value:0}
          power:{type:'f', value:0}
          area:{type:'f', value:0}
        }
      })
    )
    @mainScene.add(@_movMesh)

    @_video.addEventListener('loadeddata', (e) =>
      @_resize()
    )

    @_video.src = @_movSrc
    if isMobile.any
      @_video.load()
    else
      @_video.play()



  # -----------------------------------------------
  # 更新
  # -----------------------------------------------
  _update: =>

    super()

    @_movMesh.material.uniforms.power.value = 0.02
    @_movMesh.material.uniforms.area.value = Func.sin2((new Date()).getTime() * 0.001) * 100 * 0.002
    @_movMesh.material.uniforms.time.value += 0.1

    if @_video.duration? && @_video.duration > 0

      if isMobile.any
        @_video.currentTime += 0.02
        if @_video.currentTime >= @_video.duration
          @_video.currentTime = 0

      @_tex.needsUpdate = true



  # -----------------------------------------------
  # リサイズ
  # -----------------------------------------------
  _resize: =>

    # 画面サイズ
    w = window.innerWidth
    h = window.innerHeight

    # 画面にFIXするように
    movW = w
    movH = @_video.videoHeight * (movW / @_video.videoWidth)
    if movH < h
      movH = h
      movW = @_video.videoWidth * (movH / @_video.videoHeight)
    @_movMesh.scale.set(movW, movH, 1)

    @camera.aspect = w / h
    @camera.updateProjectionMatrix()
    @camera.position.z = h / Math.tan(@camera.fov * Math.PI / 360) / 2

    @renderer.setPixelRatio(window.devicePixelRatio || 1)
    @renderer.setSize(w, h, true)
    @renderer.clear()














module.exports = MovieCanvas
