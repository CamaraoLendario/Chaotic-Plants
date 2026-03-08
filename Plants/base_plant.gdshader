shader_type canvas_item;

uniform float startTime = 0.;
uniform bool animate = false;

void vertex() {
	if (animate){
		float time = TIME * 1.5;
		time += startTime;
		VERTEX.x += sin(time) * (1. - UV.y) * 20.;
		VERTEX.y -= sin(time*4.) * (1. - UV.y) * 10.;
	}
}