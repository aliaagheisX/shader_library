
#define SMOOTH(r,R) (1.0-smoothstep(R-0.001,R+0.001, r))
#define RANGE(a,b,x) ( step(a,x)*(1.0-step(b,x)) )
#define RANGE_SMOOTH(a,b,x) ( smoothstep(a-0.001,a+0.001,x)*(1.0-smoothstep(b-0.001,b+0.001,x)) )

#define PI 3.14159265359
#define TWO_PI 6.28318530718

#define blue4 vec3(0.953,0.969,0.89)

uniform vec4 tint;
uniform vec2 highlightCenter; // Center of the highlight
uniform float highlightRadius; // Radius of the highlight
uniform float highlightIntensity; // Intensity of the highlight
void main() {

    vec2 st = gl_FragCoord.xy / iResolution.xy;
    vec3 color = vec3(0., 0., 0.);
    st -= .5;
    color = mix(1.0, 0.0, length(st) * 2.0f) * vec3(0.89, 1.0, 0.91);
    gl_FragColor = vec4(color, 1.0);

}