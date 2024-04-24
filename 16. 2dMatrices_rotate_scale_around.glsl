#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359
#define TWO_PI 6.28318530718



// top_righ point, bottom_left point
vec3 plot_rect(in vec2 st, in vec2 tr, in vec2 bl) {
    return vec3(
        (smoothstep(tr.x, tr.x+.001, st.x)
        - smoothstep(bl.x, bl.x+.001, st.x)) * (
            smoothstep(tr.y, tr.y+.001, st.y)
        - smoothstep(bl.y, bl.y+.001, st.y)
        )
        
    );
}

vec3 plot_rect_outline(in vec2 st, in vec2 tr, in vec2 bl, in float th ) {
    vec3 rect = plot_rect(st, tr, bl);
    vec3 rect1 = plot_rect(st, tr+th, bl-th);

    return vec3(rect1 * (1.0 - rect));
}

vec3 plot_cross(in vec2 st, float sz) {
  
    return 
    plot_rect(st, vec2(sz/3., sz), - vec2(sz/3., sz)) +
    plot_rect(st, vec2(sz, sz/3.), - vec2(sz, sz/3.));
}

mat2 rotate2d(float _a) {
    return mat2(cos(_a), -sin(_a), 
                sin(_a), cos(_a));
}

mat2 scale2d(float _s) {
    return mat2(
        _s, 0.,
        0., _s
    );
}
void main() {
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    // move
    st -= .5;
    // scale
    st = scale2d(sin(iTime)+1.2)*st;
    st = rotate2d(sin(iTime)*PI ) * st  ;

    vec3 color = vec3(0.0);

    // color += vec3(1.0, 0.0, 0.0) * plot_rect(st, vec2(0.1), vec2(-.1));
    color += plot_cross(st, 0.1);
    gl_FragColor = vec4(color, 1.0);
    
}