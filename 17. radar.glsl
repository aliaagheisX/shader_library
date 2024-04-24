
#define SMOOTH(r,R) (1.0-smoothstep(R-0.001,R+0.001, r))
#define RANGE(a,b,x) ( step(a,x)*(1.0-step(b,x)) )
#define RANGE_SMOOTH(a,b,x) ( smoothstep(a-0.001,a+0.001,x)*(1.0-smoothstep(b-0.001,b+0.001,x)) )

#define PI 3.14159265359
#define TWO_PI 6.28318530718

#define blue1 vec3(0.74,0.95,1.00)
#define blue2 vec3(0.87,0.98,1.00)
#define blue3 vec3(0.35,0.76,0.83)
#define blue4 vec3(0.953,0.969,0.89)
#define red   vec3(1.00,0.38,0.227)

#define circle(st, r) SMOOTH(length(st), r)
#define circle_line(st, r, w) RANGE_SMOOTH(length(st) - w/2.0, length(st) + w/2.0, r)
#define circle_line_grad(st, r, w, g) RANGE_SMOOTH_GRAD(length(st) - w/2.0, length(st) + w/2.0, r, g)

#define line(st, w) RANGE_SMOOTH(st.x-w/2., st.x+w/2., st.y)

float radar_outline(vec2 _st) {
    _st -= .5;
    float r = length(_st);
    float a = atan(_st.y, _st.x);

    float f = sin(iTime) * a;
    f = smoothstep(f, f+0.01, .1);

    return 1. - smoothstep(f, f+0.01, r);
} 
void main() {
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    vec4 color = vec4(0., 0., 0., 1.);
    // oultine
    vec3 color_outline =blue3;
    color.rgb = mix(color.rgb, color_outline, .15 * radar_outline(st));

    // lines
    color.rgb +=  blue4 * line(st, 0.001) * circle(st - vec2(.5), .45);
    color.rgb +=  blue4 * line(vec2(1. - st.x, st.y), 0.001) * circle(st - vec2(.5), .45);
    // circles
    color.rgb += blue3 * circle_line(st - vec2(.5), .025, 0.002);
    color.rgb += blue3 * circle_line(st - vec2(.5), .25, 0.001);
    color.rgb += blue2 * circle_line(st - vec2(.5), .45, 0.001);
    color.rgb += blue1 * circle_line(st - vec2(.5), .65, 0.005);

    // red circle
    vec2 center = vec2(sin(iTime*PI/10.)*.5+.5, cos(iTime*PI/10.+PI/2.)*.5+.5);
    color.rgb += red * circle(st - center, .007) * sin(iTime*PI*10.);
    color.rgb += red * circle_line(st - center, .01, 0.002);

    float len = length(st - center);
    float r1 = fract(iTime * 1.5) / 10.;
    float th = 0.03;
    
    color.rgb += red *  ( smoothstep(r1, r1+th,  len)- 
            step(r1 + th, len)
            );

    
    gl_FragColor = color;
}