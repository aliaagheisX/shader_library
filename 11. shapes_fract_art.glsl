#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359
#define TWO_PI 6.28318530718


void main() {
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    vec3 color = vec3(0.0);
    float d = 0.0;

    // remap the space to -1 => 1
    st = st*2. - 1.;

    d = length( abs(st)- .5 );
    // d = length( min(abs(st)-.3,0.) );
    // d = length( max(abs(st)-.3,0.) );

    color = vec3(fract(d*10.));
    

    
    gl_FragColor = vec4(color, 1.0);
    
}