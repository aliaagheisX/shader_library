#version 330 core

#define PI 3.14159265359



float plot(vec2 st, float pct){
  return  smoothstep( pct-0.02, pct, st.y) -
          smoothstep( pct, pct+0.02, st.y);
}
void main() {
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    
    // TODO: change your function
    // float y = distance(vec2(0.8, 0.4), st);
//     float y =   ( smoothstep(.1, .1+0.02, length(st - .5))- 
//             step(0.12, length(st - .5))
//             );

    float y = (sin(st.x * 2.0f * PI ) + 1.0) / 2.0;

    vec3 color = vec3(y);

    float pct = plot(st, y);

    color = (1.0-pct)*color+pct*vec3(0.0,1.0,0.0);

    gl_FragColor = vec4(color, 1.0);
}
