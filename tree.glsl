#version 330 core

#define PI 3.14159265359




void main() {
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    float x = st.x;
    float y = st.y;
        // if(sin(0.02 * PI * gl_FragCoord.x) < 0.5 && cos(0.02*PI*gl_FragCoord.y) < 0.5) {
    vec4 color1 = vec4(0.32, 0.77, 0.87, 1.0);
    vec4 color2 = vec4(0.0, 0.31, 0.94, 1.0);
    gl_FragColor = y * color1 + (1.0-y) * color2;

        if(pow((x - 0.8), 2.0) + pow((y - 0.8), 2.0) < 0.01) {
            gl_FragColor = vec4(0.95, 0.6, 0.11, 1.0);

        }

        if(pow((x - 0.5), 2.0) + pow((y +0.6), 2.0) < 0.7) {
            gl_FragColor = vec4(0.0, 0.6, 0.0, 1.0);

        }

        if((x > 0.2 && x < .3) && (y < 0.5 && y > 0.02)) {
            gl_FragColor = vec4(0.27, 0.2, 0.2, 1.0);
        }
        float eq = pow((x - 0.25), 2.0) + pow((y - 0.5), 2.0); 
        float axis_radius = 0.03;
        if(eq <= axis_radius+0.0004 && eq >= axis_radius-0.0004) {
            gl_FragColor = vec4(0.95, 0.6, 0.11, 1.0);
        }
        if(eq <= axis_radius+0.0004 && eq >= axis_radius-0.0004) {
            gl_FragColor = vec4(0.95, 0.6, 0.11, 1.0);
        }
        vec2 main_center = vec2(.25, .5);
        float radius = 0.01;
        float dx[8] = float[8](0.0, 0.1, 0.0, -0.1, -0.1, -0.1, 0.1, 0.1);
        float dy[8] = float[8](0.1, 0.0, -0.1, 0.0, -0.1, 0.1, -0.1, 0.1);
        for(int i = 4;i < 8;i++) {
            if(pow((x - main_center.x + dx[i]), 2.0) + pow((y - main_center.y + dy[i]), 2.0) < radius) {
                gl_FragColor = vec4(0.25, 0.46, 0.08, 1.0);
            }
        }
        for(int i = 0;i < 4;i++) {
            if(pow((x - main_center.x + dx[i]), 2.0) + pow((y - main_center.y + dy[i]), 2.0) < radius) {
                gl_FragColor = vec4(0.35, 0.7, 0.06, 1.0);
            }
        }
       
}
