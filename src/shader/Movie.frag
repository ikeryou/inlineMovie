
uniform sampler2D tDiffuse;
uniform float time;
uniform float power;
uniform float area;

varying vec2 vUv;

void main(void) {

  vec4 destA = texture2D(tDiffuse, vUv + sin(time + gl_FragCoord.y * power) * cos(time + gl_FragCoord.x * power) * area);
  vec4 destB = texture2D(tDiffuse, vUv + cos(time + gl_FragCoord.y * power) * sin(time + gl_FragCoord.x * power) * area);
  vec4 destC = texture2D(tDiffuse, vUv + cos(time + gl_FragCoord.y * power) * cos(time + gl_FragCoord.x * power) * area);

  float p = 1.1;
  float p2 = 4.0;
  destA.r *= sin(time + gl_FragCoord.y * p) * p2;
  destB.g *= sin(time + gl_FragCoord.y * p * 0.9) * p2;
  destC.b *= cos(time + gl_FragCoord.y * p * 0.8) * p2;

  gl_FragColor = destA * destB * destC;

}
