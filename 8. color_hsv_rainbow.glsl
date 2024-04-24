#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359
#define TWO_PI 6.28318530718

vec3 rgb2hsb( in vec3 c ){
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz),
                 vec4(c.gb, K.xy),
                 step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r),
                 vec4(c.r, p.yzx),
                 step(p.x, c.r));
    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)),
                d / (q.x + e),
                q.x);
}

//  Function from Iñigo Quiles
//  https://www.shadertoy.com/view/MsS3Wc
vec3 hsb2rgb( in vec3 c ){
    vec3 rgb = clamp(abs(mod(c.x*6.0+vec3(0.0,4.0,2.0),
                             6.0)-3.0)-1.0,
                     0.0,
                     1.0 );
    rgb = rgb*rgb*(3.0-2.0*rgb);
    return c.z * mix(vec3(1.0), rgb, c.y);
}


// linear space
vec3 rainbow_linear(in vec2 st) {
    return hsb2rgb(vec3(st.x, 1.0, st.y));
}

vec3 rainbow_polar(in vec2 st) {
    vec2 v = vec2(0.5) - st;
    float sat = length(v) * 2.0;
    float hue = (atan(v.y, v.x) / TWO_PI + .5); //  tan(iTime);


    return hsb2rgb(vec3(hue, sat, 1.0));
}
void main() {
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    
    vec3 color = vec3(0.0);
    //color = rainbow_linear(st);
    color = rainbow_polar(st);
    gl_FragColor = vec4(color, 1.0);
    
}