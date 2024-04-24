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

vec3 plot_box(in vec2 _st, in vec2 _sz) {
    vec2 horiz = _sz * vec2(1., .25);
    vec2 vert = _sz * vec2( .25, 1.);
    return vec3(
            plot_rect(_st,  horiz,  - horiz) +
            plot_rect(_st, vert, - vert)
    );
}
void main() {
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    // st = st - (vec2(cos(iTime), sin(iTime)) * .5 + .5) ;
    vec2 translate = (vec2(cos(iTime), sin(iTime)) + 1.) *.5;
    st -= translate ;
    vec3 color = vec3(0.0);
    color = vec3(st.x,st.y,0.0);

    color += plot_box(st, vec2(.035));
    gl_FragColor = vec4(color, 1.0);
    
}