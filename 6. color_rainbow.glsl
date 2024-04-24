#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359


vec3 colors[6] = vec3[6](
                    vec3(0.0, 0.0, 1.0), 
                    vec3(0.0, 0.93, 1.0),
                    vec3(0.0, 1.0, 0.0),
                    vec3(1.0, 0.9, 0.0),
                    vec3(1.0, 0.57, 0.0),
                    vec3(1.0, 0.0, 0.0)
);

float radius = 0.06;


float plot (vec2 st, float pct, float th){
  return  smoothstep( pct-th, pct, st.y) -
          smoothstep( pct, pct+th, st.y);
}

void main() {
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    
    vec3 color = vec3(1.0);

    for(int i = 0;i < 6;i++) {
      float circle = distance(vec2(0.5, 0.0), st);
      if(circle < 0.3+(0.02*float(i)) && circle > 0.2+(0.02*float(i)) ) {
        color = colors[i];
      }
    }
    // color = mix(color, color1, plot(st, y, 0.1));

    gl_FragColor = vec4(color, 1.0);
    
}