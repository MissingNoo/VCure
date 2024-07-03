varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float iBlur; // can be a var instead of a uniform
uniform float iTime; // not required

void main()
{
    // float ti = fract(iTime)*10.; // not required but can be used for changeing blur or use sin() function for pulsating
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord, iBlur ); // all you need to do is have the 3rd paramater bias (iBlur) which works now that we have mippmapping on can also iBlur*ti or just ti for 3rd parameter
}