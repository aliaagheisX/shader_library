#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359


vec3 color_l1 = vec3(0.623, 0.75, 0.9);
vec3 color_l2 = vec3(0.16, 0.15, 0.9);

vec3 color_s1 = vec3(1.0, 0.9, 0.01);
vec3 color_s2 = vec3(0.85, 0.31, 0.07);


float plot (vec2 st, float pct){
  return  smoothstep( pct-0.01, pct, st.y) -
          smoothstep( pct, pct+0.01, st.y);
}

void main() {
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    
    float y = distance(vec2(0.8, 0.4), st) ;
    float angle = sin(0.5*PI*iTime);
    vec3 color = mix(mix(color_s2, color_s1, angle), mix(color_s1, color_s2, angle), vec3(1.0*y));
    color = mix(color, mix(color_l2, color_l1, angle), smoothstep(0.4, 1.0, y)*0.7);
    // vec3 color = mix(color_l1, color_l2, smoothstep(1.0, 0.7, 1.0 - st.y));
    // color = mix(color, color3, smoothstep(0.45, 0.55, 1.0-st.y));
    // color = mix(color, color4, smoothstep(0.6, 0.2, st.y));


    gl_FragColor = vec4(color, 1.0);
    
}