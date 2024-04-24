#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359
#define TWO_PI 6.28318530718



// top_righ point, bottom_left point
vec3 plot_rect(in vec2 st, in vec2 tr, in vec2 bl) {
    return vec3(
            (step(tr.x, st.x) - step(bl.x, st.x)) *
            (step(tr.y, st.y) - step(bl.y, st.y))
    );
}

vec3 plot_rect_outline(in vec2 st, in vec2 tr, in vec2 bl, in float th ) {
    vec3 rect = plot_rect(st, tr, bl);
    vec3 rect1 = plot_rect(st, tr+th, bl-th);

    return vec3(rect1 * (1.0 - rect));
}
void main() {
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    vec3 color = vec3(0.0);

    // vec2 bl = step(vec2(0.1), st);
    // vec2 tr =  step(vec2(0.1), 1.0 - st);
    // vec2 bl = smoothstep(0.0, 0.1, st);
    // vec2 tr =  smoothstep(0.0, 0.1, 1.0 - st);
    // vec2 bl = floor(-st  + 0.1 );
    // vec2 tr =  1.0 - floor(st + 0.1 );

    // plot outline
    vec2 tr = vec2(0.5, 0.5);
    vec2 bl = vec2(0.1, 0.1);
    //color = plot_rect(st, tr, bl);
    color = vec3(sin(iTime)*0.5+0.5, cos(iTime)*0.5+0.5, 0.0) * plot_rect_outline(st, tr, bl, 0.01);

    gl_FragColor = vec4(color, 1.0);
    
}