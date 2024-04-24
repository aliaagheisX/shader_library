#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359
#define TWO_PI 6.28318530718

float plot(float r, float pct){
  return  smoothstep( pct-0.02, pct, r) -
          smoothstep( pct, pct+0.02, r);
}


void main() {
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    st -= .5;
    vec3 color = vec3(0.0);

    vec2 pos =  st;
    // make radius from 0->1 instead from 0->0.5
    float r = length(pos) ;
    float a = atan(pos.y, pos.x);
    // floar
    float f = a*sin(iTime) ;
    f = smoothstep(f-0.01, f+0.01, .1);
    // f = a*.5;
    // f = abs(cos(angle*3.));
    // f = abs(cos(a*12.))*.8+.1;
    //f = abs(cos(a*12.)*sin(a*3.))*.8+.1;
    // gear
    // f = smoothstep(-.1,1., cos(a*5.))*0.1+0.3;
    // flour
    // max(radius in center, sin(#leafs * a + ...)*diameter)
    // f = max(.02, sin(10.*a + PI*iTime)*.05+.05);
    // f = cos(a * 2.)*.2+.5*cos(iTime)+.5;
    float pct = plot(r, f);
    color = vec3(1.0, 0.69, 0.69) * vec3(1.0 - smoothstep(f, f+0.01, r));
    // draw contour
    color = (1.0-pct)*color+pct*vec3(0.0,1.0,0.0);

    gl_FragColor = vec4(color, 1.0);
    
}