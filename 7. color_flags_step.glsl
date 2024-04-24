#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359




float plot (vec2 st, float pct){
  return  smoothstep( pct-0.01, pct, st.y) -
          smoothstep( pct, pct+0.01, st.y);
}

void main() {
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    

    vec3 color = vec3(0.31, 0.2, 0.2);

    color = mix(vec3(0.0, 1.0, 1.0), color, step(0.3, st.x));
    color = mix(vec3(1.0, 0.0, 0.4), color,   1.0 - step(0.6, st.x));


    gl_FragColor = vec4(color, 1.0);
    
}