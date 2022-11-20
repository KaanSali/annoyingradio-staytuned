shader_type canvas_item;
uniform bool grayscale = false;
uniform sampler2D screenTexture; 
uniform float brightness = 0.5;
uniform float contrast = 0.5;
uniform float saturation = 0.5;
uniform float alpha = 1.0;
void fragment() {
	if(grayscale){
		vec4 texColors = texture(screenTexture, UV);
		COLOR.rgb = vec3(dot(texColors.rgb,vec3(brightness,contrast,saturation)));
		if(length(COLOR.rgb) > length(vec3(0.8))){
			COLOR.a = 0.0;
		}
	}
	else
	{
		COLOR = texture(screenTexture,UV);
		COLOR.a = alpha;
	}
	
}
