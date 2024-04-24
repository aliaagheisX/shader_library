#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359
#define TWO_PI 6.28318530718


vec3 plot_circle(in vec2 st, in vec2 center, in float radius) {
    return 1.0 - vec3(
        step(radius, distance(st, center))
    );
}

vec3 plot_cricle_optimized(in vec2 st, in vec2 center, in float radius) {
    vec2 dist = st - center;
    return vec3(
        1. - smoothstep(0.99*radius, radius*1.001,
                         dot(dist,dist)*2.0)
    );
}

void main() {
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    vec3 color = vec3(0.0);
    float pct = 0.0;

    // pct = step(0.5, distance(st, vec2(0.5)));
    // color = plot_circle(st, vec2(0.4, 0.3), 0.1);

    // color = color * vec3(0.0, 0.0, 1.0);

    // pct = distance(st,vec2(0.4)) + distance(st,vec2(0.6));
    // pct = distance(st,vec2(0.4)) * distance(st,vec2(0.6));

    // two points with like refraction between them
    pct = min(
        distance(st,vec2(sin(iTime), cos(iTime)) * 0.5 + 0.5),
        distance(st,vec2(sin(iTime + PI), cos(iTime + PI)) * 0.5 + 0.5)
    );

    // line between points
    // pct = max(distance(st,vec2(0.4)),distance(st,vec2(0.6)));

    // two points 1 black 1 white
    //pct = pow(distance(st,vec2(0.2)),distance(st,vec2(0.6)));

    //color =  ( vec3(pct)) ;//* vec3(0.0, 0.47, 1.0);
    color = plot_cricle_optimized(st, vec2(.5), 0.5);
    

    gl_FragColor = vec4(color, 1.0);
    
}