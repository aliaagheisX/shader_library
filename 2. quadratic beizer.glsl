#version 330 core

#define PI 3.14159265359



float plot(vec2 st, float pct){
  return  smoothstep( pct-0.02, pct, st.y) -
          smoothstep( pct, pct+0.02, st.y);
}

// a = point.x, b = point.y
float quadraticBezier(float x, float a, float b){
  float t = (sqrt(a*a+(1.0-2.0*a)*x) - a) / (1.0 - 2.0*a);
  return (1.0 - 2.0*b)*t*t + 2.0*b*t;
}

void main() {
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    
    float y = quadraticBezier(st.x, 0.8, 0.1);

    vec3 color = vec3(y);

    float pct = plot(st, y);

    color = (1.0-pct)*color+pct*vec3(0.0,1.0,0.0);

    gl_FragColor = vec4(color, 1.0);
}
