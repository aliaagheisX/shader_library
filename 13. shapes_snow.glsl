// REFERENCE
// https://www.shadertoy.com/view/XlSBz1

precision highp float;

#define PI 3.14159265359
#define TWO_PI 6.28318530718
#define time (iTime / 2.)


// convert point to polr
#define p_to_pc(p) vec2(atan(p.y, p.x), length(p))
// convert polar to point
#define pc_to_p(p) vec2(p.y * cos(p.x), p.y * sin(p.x));





// I use these fields to create and tweak the snowflakes
vec2 fieldA(vec2 pc){
    pc.y += .02 * floor( 5. * cos(pc.x * 6. ));
    pc.y += .01 * floor(10. * cos(pc.x * 30.));
    pc.y += .5  * cos(pc.y * 10.);
    return pc;
}



vec2 fieldB(vec2 pc, float f){
    pc.y += .1 * cos(pc.y * 100. + 10.);
    pc.y += .1 * cos(pc.y *  20. + f  );
    pc.y += .04* cos(pc.y *  10. + 10.); 
    return pc;
} 

float snow_flake(vec2 p, float f){
	vec2 pc = p_to_pc(vec2(p*10.)); 
    pc = fieldA(fieldB(pc, f));
    return float( length(pc.y) < .3) ;
}

float snow(vec2 p){
	p.y += 2. * time;
    p = fract(p + .5) - .5;
    p.x += .01 * cos( dot(p,vec2(3)) + time * 6.28);
    
    return snow_flake(p, 1.)
         + snow_flake(p + vec2( .2,-.1), 4.)
         + snow_flake(p + vec2(-.2, .4), 9.)
         + snow_flake(p*2. + vec2(-.4, -.5), 5.)
         + 2.0 * snow_flake(p * 1. + vec2(.4, -.4), 5.)
         + snow_flake(p + vec2(-1.2, 1.2), 9.)
         + snow_flake(p + vec2( 2.4,-1.2), 5.)
         + snow_flake(p + vec2(-1.2, 1.1), 9.);

}

void main() {
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    vec4 color = vec4(0.0);

    vec2 p = st - .5;
    

    color +=  vec4(.2, .4, .7, 1)
          + .3 * snow(p * 2.)
          + .2 * snow(p * 4. + vec2(time, 0.0))
          + .1 * snow(p * 8.);
    gl_FragColor = vec4(color);
    
}