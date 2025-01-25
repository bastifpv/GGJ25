shader_type spatial;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 R = TEXTURE_PI.xy,  u = f/R;
    vec4 st = texture2D(iChannel1, u);
    float  y = iMouse.y,
          s1 = texture2D(iChannel0, u                ).r,
          s2 = texture2D(iChannel0, u - sin(y*.03 )/R).b,
          s3 = texture2D(iChannel0, u + cos(y*.018)/R).g,
           d = pow(abs(f.y-y)*.003,.6);

   o = vec4(.96, .66, .14, 1) +.06*st + .3*(1.-d)*(2.*s1*s2*s3+ st*d);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
