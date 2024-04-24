#define PI 3.14159265358979323846

#define SMOOTH(r,R) (1.0-smoothstep(R-0.001,R+0.001, r))
#define RANGE(a,b,x) ( step(a,x)*(1.0-step(b,x)) )
#define RANGE_SMOOTH(a,b,x) ( smoothstep(a-0.001,a+0.001,x)*(1.0-smoothstep(b-0.001,b+0.001,x)) )


#define RECT(st, w, h) RANGE_SMOOTH(-w/2., w/2., st.x)*RANGE_SMOOTH(-h/2., h/2., st.y)
vec2 rotate2D(vec2 _st, float _angle){
    _st -= .5;
    _st =  mat2(cos(_angle),-sin(_angle),
                sin(_angle),cos(_angle)) * _st;
    return _st;
}
void main(){
    vec2 st = gl_FragCoord.xy/iResolution.xy;
    vec3 color = vec3(0.0);
    st = fract(st * 4.);
    st = rotate2D(st, PI*.25);

    color = vec3(RECT(st, .7, .7));
    // color = vec3(mod(floor(st.x), 2.) * mod(floor(st.y), 2.));
    gl_FragColor = vec4(color,1.0);
}