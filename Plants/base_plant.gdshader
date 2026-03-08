shader_type canvas_item;

void vertex() {
	float time = TIME*1.5;
	VERTEX.x += sin(time) * (1. - UV.y) * 20.;
	VERTEX.y -= sin(time*4.) * (1. - UV.y) * 10.;
}