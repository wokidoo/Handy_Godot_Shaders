// Returns a wave along the axis of a mesh

// !!!PARAMETERS!!!
// axis: mesh axis along which the wave will move (e.g VERTEX.y)
// amplitude: amplitude of the wave
// frequency: number of frequencies per axis length
// animation_speed: multiplier altering the speed of the wave movement

float wave(float axis, float amplitude, float frequency, float animation_speed){
	return amplitude*cos((axis + TIME*animation_speed)*frequency);
}
