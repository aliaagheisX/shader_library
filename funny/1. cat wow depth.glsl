#iChannel0 "../assets/pickle_cat.png"
#iChannel1 "../assets/picke_cat_heightmap.jpg"

vec2 cycle(float theta) {
    return vec2(cos(theta), sin(theta));
}

void main(){
    vec2 uv = gl_FragCoord.xy / iResolution.xy;
    float depth = texture(iChannel1, uv).r;
    
    gl_FragColor = texture(
        iChannel0, 
        uv + depth * 0.02 * cycle(iTime)
    );
    
    gl_FragColor.rgb *= gl_FragColor.a;


}